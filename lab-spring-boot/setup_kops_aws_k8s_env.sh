# Follow https://github.com/kubernetes/kops/blob/master/docs/aws.md
# to create access policies, groups and access keys. These are the commands
# aws iam create-group --group-name kops
# aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name kops
# aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name kops
# aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name kops
# aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name kops
# aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name kops
# aws iam create-user --user-name kops
# aws iam add-user-to-group --user-name kops --group-name kops
# aws iam create-access-key --user-name kops

export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
s3_bucket_name="debashis.s3.local"
cluster_name="debashiscluster.k8s.local"
aws s3api create-bucket --bucket $s3_bucket_name --region us-east-1
export KOPS_STATE_STORE=s3://$s3_bucket_name
kops create cluster --zones us-west-2a ${cluster_name}
kops update cluster ${cluster_name} --yes
