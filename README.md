# Ansible based Disconnected OpenShift 4 Backup Infra installer

This set of roles allow to backup Openshift project resources and volume data using Velero, Restic and Noobaa Operator in a disconnected environment. Noobaa can be connected to an external s3 service provider such as AWS S3 or Azure Blob Storage.
Minio Operator is installed as well as an example failover HA backing store to Noobaa or as a stand alone S3 service.

## Prerequisites
Python3 and make. All the container images in this repo are public. In order to use this playbook in a disconnected environment they will have to be pushed to an internal registry.

## Dependencies

kubernetes and openshift python modules. See `requirements.txt`.

## Install

$ make install

## Manual install

$ oc login https://api.cluster.example.net:8443 --token=${token}

$ export BACKUP_INFRA=true ansible-playbook site.yaml -v


## Notes

The following env vars can be exported while testing the playbooks manually.

K8S_AUTH_VERIFY_SSL=False

K8S_AUTH_API_KEY={{ openshift_token }}

K8S_AUTH_HOST={{ https://openshift_api_url:6443 }}
