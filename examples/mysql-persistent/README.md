# Stateful application backup/restore (mysql)

The persistent case assumes the existence of the storageclass "example-nfs" --
modify appropriately if this is incorrect for your cluster. Restic is used for PV backup.

## Create stateful mysql deploymentconfig:
```
oc create -f mysql-persistent/mysql-persistent-template.yaml
```

## Creating table in database.
```
oc rsh -n mysql-persistent $mysql-pod

mysql -u root -p
<Enter>

create database example;
use example;
CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20), species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);

quit

# Reference:
https://dev.mysql.com/doc/refman/8.0/en/creating-tables.html

```

## Back up the application.
```
oc create -f mysql-persistent/mysql-persistent-backup.yaml
```

## Delete the application.
Make sure the backup is completed:
`oc get backup -n velero mysql-persistent -o jsonpath='{.status.phase}'`

should output "Completed"). Then, run:

```
oc delete namespace mysql-persistent
```

## Restore the application.
```
oc create -f mysql-persistent/mysql-persistent-restore.yaml
```

## Compare application state before/after.
Make sure the restore is completed (`oc get restore -n velero mysql-persistent -o jsonpath='{.status.phase}'`)
should show "Completed", and the application pod should be
running. Now run:
```
oc get all -n mysql-persistent > mysql-running-after.txt
oc get pvc -n mysql-persistent >> mysql-running-after.txt
oc get pv >> mysql-running-after.txt
for pod in $(oc get pod -n mysql-persistent --field-selector=status.phase=Running --no-headers | awk '{print $1}'); do echo $pod; oc rsh -n mysql-persistent $pod ls -hal /var/lib/mysql/data/foo; done >> mysql-running-after.txt
```
Compare "mysql-running-before.txt" and "mysql-running-after.txt"
