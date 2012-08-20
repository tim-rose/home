#!/bin/sh
OPTS="d:h:p:su:"

USAGE="dbshow [-h host] [-u user] [-p password] [-d database] [tables...]"

db_database=$DB_DATABASE
db_password=$DB_PASSWORD
db_user=$DB_USER
db_host=$DB_HOST
db_opts=""

while getopts $OPTS c; do
    case $c in
    d)	db_database=$OPTARG;;
    h)	db_host=$OPTARG;;
    p)	db_password=$OPTARG;;
    s)	db_opts="$db_opts -$c";;
    u)	db_user=$OPTARG;;
    \?) echo $USAGE >&2; exit 2;;
    esac
done
shift `expr $OPTIND - 1`

credentials=""
if [ ! -z "$db_user" ]; then
    credentials="$credentials -u$db_user"
fi
if [ ! -z "$db_password" ]; then
    credentials="$credentials -p$db_password"
fi
if [ ! -z "$db_host" ]; then
    credentials="$credentials -h$db_host"
fi
if [ ! -z "$db_database" ]; then
    credentials="$credentials -D$db_database"
fi

tables="$*"
if [ ! -z "$tables" ]; then
    for t in $tables; do
	mysql $db_opts $credentials -e "show table $t"
    done
else
    mysql $db_opts $credentials -B -e "show tables"|sed -e 1d
fi
