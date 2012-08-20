#!/bin/sh
mysql_flags="stqrbAHifBT"
OPTS="d:h:p:su:$mysql_flags"

USAGE="db [-h host] [-u user] [-p password] [-d database] [<sql-command>]"

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
    u)	db_user=$OPTARG;;
    [$mysql_flags]) db_opts="$db_opts -$c";;
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

cmd="$*"
if [ ! -z "$cmd" ]; then
    mysql $db_opts $credentials -B -e "$cmd"
else
    echo "db: $db_user@$db_database" >&2
    mysql $db_opts $credentials
fi
