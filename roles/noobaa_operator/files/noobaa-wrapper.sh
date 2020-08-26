base_dir=${1}
namespace=${2:-noobaa}

core_image=docker.io/noobaa/noobaa-core:5.5.0
database_image=docker.io/centos/mongodb-36-centos7
operator_image=docker.io/noobaa/noobaa-operator:2.3.0
storage_class=local-sc


${base_dir}/noobaa install -n $namespace --noobaa-image=$core_image --operator-image=$operator_image --db-image=$database_image --db-storage-class=$storage_class --pv-pool-default-storage-class=$storage_class

