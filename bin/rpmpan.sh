#!/bin/sh
#
# RPMPAN --build a RPM repository from CPAN
#
. ~/bin/log.sh

site=www.cpan.org
#
# get_pkg() --return a list of *all* the CPAN packages
#
get_pkg()
{
    dir=modules
    file=02packages.details.txt.gz
    rm -f $file
    if wget -q $site/$dir/$file; then
	InfoMsg "Downloaded package information"
	f=`basename $file .gz`
	gunzip -f $file
	sed -e '1,/^$/d' <$f
	rm $f
    else
	FatalMsg "Failed to download $file"
	exit 1
    fi
}


#
# get_author() --return a list of *all* the CPAN authors
#
get_author()
{
    dir=authors
    file=00whois.html
    rm -f $file
    if wget -q $site/$dir/$file; then
	InfoMsg "Downloaded author information"
	grep "^<a" <$file | 
	    sed -e "s|^<a[^>]*></a>||" \
	        -e "s|<a[^>]*>||g" \
	        -e "s|</a>||g"  \
	        -e "s|&lt;|<|g"  \
	        -e "s|&gt;|>|g"
	rm $file
    else
	FatalMsg "Failed to download $file"
	exit 1
    fi
}

#
# extract module usage from a bunch of files in a diretory tree.
#
# Remarks:
# Packages provided by the base perl install are excluded, as
# are (sub) packages provided by the thing being installed
# This is a little flaky, because the "use" word can occur at the start of
# line in other contexts. I need a clean way of having other stop-lists(?).
#
get_perl_use()
{
    find . -type f -name $1 | xargs cat |
        sed -ne "s/^use[ 	][ 	]*\([a-zA-Z_:][a-zA-Z_:]*\).*/\1/p" |
        sort -u | fgrep -vf ../perl-provides.txt | fgrep -v $2 |
	egrep -v "^(a|it|just|the|this|to)\$"
}


get_build_req()
{
    get_perl_use "*.PL" $1
}


get_req()
{
    get_perl_use "*.pm" $1
}


#
# main...
#
if [ ! -f pkg.txt ]; then
    get_pkg > pkg.txt		# update list of packages
    sed -e 's/  */,/g' <pkg.txt >pkg.csv
fi
if [ ! -f author.txt ]; then
    get_author > author.txt	# can't use ","; use "|" instead
    sed -e 's/  */|/' <author.txt >author.tsv
fi
if [ ! -f perl-provides.txt ]; then 
    rpm -q --provides perl |
        sed -e "s/ .*//" -e"/\.so\$/d" -e "/^perl\$/d" \
	    -e "s/^perl(//" -e "s/)\$//" >perl-provides.txt
fi
if [ $# = 0 ]; then
   pkgs=`cut -d'\t' -f3 <pkg.csv | sort -u | sed -e 's|.*/||'`
else
   pkgs=$*
fi

while [ "$pkgs" != "" ]; do
    InfoMsg "Packages: $pkgs"
    p=$pkgs
    pkgs=""
    for pkg in $p; do
	InfoMsg "Package: $pkg"
	case $pkg in
	*::*)
	    file=`grep "^$pkg," <pkg.csv |  cut -d, -f3`
	    pkg_name=`grep "^$pkg," <pkg.csv |  cut -d, -f1`
	    InfoMsg "Package: $pkg ($pkg_name), file=\"$file\""
	    ;;
	*.tar.gz)
            file=`grep "$pkg\$" <pkg.csv | cut -d, -f3 | sort -u`
	    pkg_name=`grep "$pkg\$," <pkg.csv |  cut -d, -f1`
	    InfoMsg "Package: $pkg ($pkg_name), file=\"$file\""
	    ;;
        *)
	    ErrorMsg "Unknown package: $pkg"
	    file="(unkown $pkg)"
	    ;;
        esac
	tgz=`basename $file`
	if [ -f $tgz ]; then
	    InfoMsg "$tgz already exists"
	elif wget -q $site/authors/id/$file; then
	    InfoMsg "downloaded file $tgz"
	    auth=`dirname $file`
	    auth=`basename $auth`
	    name=`grep "$auth|" <author.tsv|cut -d"|" -f1`
	    auth=`grep "$auth|" <author.tsv|cut -d"|" -f2`
	    mkdir ./tmp; cd ./tmp
	    tar zxf ../$tgz
	    build_req=`get_build_req $pkg_name`
	    req=`get_req $pkg_name`
	    pkgs="$pkgs $build_req $req"
	    cd ..; rm -rf ./tmp
#	    InfoMsg "cpanflute2 --buildall --noperlreqs --email='$auth' $tgz"
#	    cpanflute2 --buildall --noperlreqs --email="$auth" $tgz >$pkg_name.log 2>&1
	    InfoMsg ""
	    cpan2rpm --tempdir ~/tmp $tgz |tee $pkg_name.log 2>&1
	else
	    ErrorMsg "Failed to download $file"
	fi
    done
done
