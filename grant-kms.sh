aws kms create-grant \
  --region us-west-2 \
  --key-id arn:aws:kms:us-east-1:041445559784:key/bbcec40c-e637-45dd-8f1a-8fce019cf076 \
  --grantee-principal arn:aws:iam::111122223333:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling \
  --operations "Encrypt" "Decrypt" "ReEncryptFrom" "ReEncryptTo" "GenerateDataKey" "GenerateDataKeyWithoutPlaintext" "DescribeKey" "CreateGrant"
