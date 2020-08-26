# Openshift v4.5 Etcd Backup Role

This role takes a snapshot of Etcd into a pvc mounted directory using etcdctl.
In future releases of OpenShift, backups will most likely be handled by an Etcd Operator.


## Parameters

| Parameter                | Default Value                  | Description                       |
| ------------------------ | ------------------------------ | --------------------------------  |
| etcd_cluster_id          | demo                           | Cluster id                        |
| etcd_backup_namespace    | etcd-backup                    | Etcd backup namespace             |
| etcd_backup_schedule     | 0 1 * * *                      | Run once daily at 1 AM            |
| etcd_backup_storageclass | local-sc                    | The default storage class         |
| etcd_backup_volume_size  | 10Gi                           | Backup_volume_size                |

It's recommended to override the `etcd_cluster_id` and `etcd_backup_volume_size` variables when invoking the role.

ansible-playbook ansible-playbook playbooks/etcd-backup/config.yaml \
                 -e etcd_cluster_id=hgh_ocp4 \
                 -e etcd_backup_volume_size=20Gi


## Python / Ansible modules used

kubernetes, openshift, jmespath
