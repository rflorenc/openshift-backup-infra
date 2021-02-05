# Ansible based Disconnected OpenShift 4 Backup Infra installer

This set of roles allow to backup Openshift project resources and volume data using Velero, Restic and Noobaa Operator in a disconnected environment. Noobaa can be connected to an external s3 service provider such as AWS S3 or Azure Blob Storage.
Minio Operator is installed as well as an example failover HA backing store to Noobaa or as a stand alone S3 service.

## Prerequisites

Linux OS, Python3 and make. 
All the container images in this repository are public. In order to use this playbook in a disconnected environment they will have to be tagged and pushed to an internal registry. The ansible variables will need to be adapted accordingly. See `docker_images.list`.

## Dependencies

kubernetes and openshift python modules. See `requirements.txt`.

## Install

<<<<<<< Updated upstream
$ oc login https://api.cluster.example.net:8443 --token=${token}

$ export STORAGE_CLASS=${exampleStorageClass}

$ make 

 
 
## Manual install

$ oc login https://api.cluster.example.net:8443 --token=${token}

$ ansible-playbook site.yaml -v --extra-vars "storage_class=${exampleStorageClass}
=======
$ oc login https://api.cluster.example.net:8443 --token=${token}

$ export STORAGE_CLASS=$exampleStorageClass
>>>>>>> Stashed changes

$ make

## Notes

* The `velero` and `noobaa` binaries used in the repository are ELF 64-bit x86-64 executables.

* No SSH access is required to the cluster nodes.

* Any http_proxy configuration will have to be done manually, either for pip configuration or access to an internal registry.


The following env vars can be exported while testing the playbooks manually.
```
K8S_AUTH_VERIFY_SSL=False
K8S_AUTH_API_KEY={{ openshift_token }}
K8S_AUTH_HOST={{ https://openshift_api_url:6443 }}
```
