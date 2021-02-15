bucket=${1:-first.bucket}
destination=/tmp/$bucket

unset NOOBAA_ACCESS_KEY
unset NOOBAA_SECRET_KEY

NOOBAA_ACCESS_KEY=$(oc get secret noobaa-admin -n noobaa-operator -o json | jq -r '.data.AWS_ACCESS_KEY_ID|@base64d')
NOOBAA_SECRET_KEY=$(oc get secret noobaa-admin -n noobaa-operator -o json | jq -r '.data.AWS_SECRET_ACCESS_KEY|@base64d')
export NOOBAA_ACCESS_KEY
export NOOBAA_SECRET_KEY

# kill any running `oc porforward`
# job %1
kill $(sudo netstat -ntlp | grep 10443 | awk '{print $7}' | cut -d '/' -f 1) &> /dev/null

nohup oc port-forward -n noobaa-operator service/s3 10443:443 &

echo alias 's3="AWS_ACCESS_KEY_ID=$NOOBAA_ACCESS_KEY AWS_SECRET_ACCESS_KEY=$NOOBAA_SECRET_KEY aws --endpoint https://localhost:10443 --no-verify-ssl s3"'

# Example commands
# mkdir -vp $destination
# s3 ls
# s3 sync s3://$bucket $destination
