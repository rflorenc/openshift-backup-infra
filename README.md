# Ansible based disconnected OpenShift 4.x.y backup infra

This set of roles provide the backup of Openshift resources and data by using Velero, Noobaa-operator and Restic.
Minio-operator is installed as well to be used as a failover HA backing store to Noobaa.

## Dependencies

k8s and openshift module

## Usage

$ oc login https://api.cluster.example.net:8443 --token=${token}

$ export deploy_backup_infra=true deploy_etcd=true; ansible-playbook site.yaml


## Notes

The following env vars can be exported while testing the playbooks manually.

K8S_AUTH_VERIFY_SSL=False
K8S_AUTH_API_KEY={{ openshift_token }}
K8S_AUTH_HOST={{ https://openshift_api_url:6443 }}
