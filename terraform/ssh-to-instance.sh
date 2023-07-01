PUBLIC_DNS=$(terraform output instance_public_dns | sed s/'\"'//g)
USER_NAME=$(terraform output default_user_name | sed s/'\"'//g)

terraform output -raw private_key > private_key.pem
echo "Execute the following commands to ssh into EC2 instance: chmod 400 private_key.pem && ssh -i private_key.pem $USER_NAME@$PUBLIC_DNS"

