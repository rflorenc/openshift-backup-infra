# Stateful application backup/restore (mysql)

This example is almost the same as the one at https://github.com/konveyor/velero-examples

The differences are:
* we are using a Deployment controller instead of a DeploymentConfig.
* we are adding a dummy database to the mysql pod.
* we are leveraging openshift-velero-plugin and a custom restic-restore-helper image.

The persistent case assumes the existence of the storageclass "example-nfs".

Modify the PersistentVolumeClaim: spec.storageClassName appropriately at `mysql-persistent/mysql-persistent-template.yaml`.

## Create stateful mysql Deployment:
```
oc create -f mysql-persistent/mysql-persistent-template.yaml
```

## Create a table in the database.
```
oc rsh -n mysql-persistent $mysql-pod

mysql -u root -p
<Enter>

create database menagerie;
use menagerie;
CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20), species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);

quit

# Reference:
https://dev.mysql.com/doc/refman/8.0/en/creating-tables.html

```

## Back up the application.
```
oc create -f mysql-persistent/mysql-persistent-backup.yaml

# Alternative
velero backup create mysql-persistent --include-namespaces mysql-persistent
```

## Delete the application.
Make sure the backup is completed:

`oc get backup -n velero mysql-persistent -o jsonpath='{.status.phase}'`

Then, run:

```
oc delete namespace mysql-persistent

# ensure all resources are deleted before proceeding.
```

## Restore the application.
```
oc create -f mysql-persistent/mysql-persistent-restore.yaml

# Alternative
velero restore create mysql-persistent --from-backup=mysql-persistent
```

## Compare application state before/after.
Make sure the restore is completed:

`oc get restore -n velero mysql-persistent -o jsonpath='{.status.phase}'`

should show "Completed", and the application pod should be running. Now run:


```
oc project mysql-persistent
oc get all -n mysql-persistent
oc get pvc -n mysql-persistent

oc rsh -n mysql-persistent $mysql-pod

mysql -u root -p
use menagerie;
describe pet;

```
