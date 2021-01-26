# Minio Operator Role

Minio Operator Role installs Minio Operator on OpenShift 4.

## Upstream documentation

* https://github.com/minio/minio-operator

## Parameters

| Parameter                | Default Value                  | Description                       |
| ------------------------ | ------------------------------ | --------------------------------  |
| minio_operator_namespace | minio-operator                 | Minio namespace                   |
| minio_operator_replicas  | 1                              | Minio number replicas             |
| minio_operator_image_tag | v3.0.9                         | Container image tag               |
| minio_operator_accesskey | bWluaW8=                       | base 64 encoded                   |
| minio_operator_secretkey | bWluaW8xMjM=                   | based 64 encoded                  |
