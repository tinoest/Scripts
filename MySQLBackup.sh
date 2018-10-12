#!/bin/bash
backupdir='/mnt/backup/';
day=`date +%u`;
mkdir -p $backupdir/$day;

echo "MySQL Backup for $HOSTNAME";
echo "================================="
echo `date`;
for database in `/usr/bin/mysql -uroot -hlocalhost -e 'show databases;' | awk '{print $1}' | grep -vE '\||^$|Database'`;
do
	printf "Exporting $database...";
	/usr/bin/mysqldump -uroot $database --single-transaction --quick --lock-tables=false | /bin/gzip -c > $backupdir/$day/$database.sql.gz;
	/bin/chmod 600 $backupdir/$day/$database.sql.gz;    
	printf "done\n";
done
exit 0;
