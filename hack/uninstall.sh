#!/bin/bash

noobaa_ns=noobaa-operator
for project in minio-operator velero; do oc delete project $project &> /dev/null; done

oc patch bucketclass -n $noobaa_ns --type=merge -p '{"metadata":{"finalizers":null}}' noobaa-default-bucket-class
oc patch noobaa -n $noobaa_ns --type=merge -p '{"metadata":{"finalizers":null}}' noobaa

for pod in `oc get pods -o jsonpath='{.items[*].metadata.name}' -n $noobaa_ns`;do oc patch pod -n $noobaa_ns --type=merge -p '{"metadata":{"finalizers":null}}' $pod ;done
../roles/noobaa_operator/files/noobaa uninstall --cleanup=true -n $noobaa_ns >> /tmp/noobaa_uninstall.log 2>&1
