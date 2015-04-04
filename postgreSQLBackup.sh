#!/bin/bash
backupdir='/Users/martyn/PostgreSQL/Backup/';
day=`date +%u`;
mkdir -p $backupdir/$day;

echo "PostgreSQL Backup for $HOSTNAME";
echo "================================="
echo `date`;
for database in `/sw/bin/psql -U postgres -lt | awk '{print $1}' | grep -vE '\||^$|template0'`;
do
				printf "Exporting $database...";
				/sw/bin/pg_dump -U postgres -c $database | gzip -c > $backupdir/$day/$database.sql.gz;
				/bin/chmod 600 $backupdir/$day/$database.sql.gz;    
				printf "done\n";
done
echo `date`;
echo;
exit 0;
