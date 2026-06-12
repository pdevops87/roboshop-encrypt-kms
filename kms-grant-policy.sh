aws kms create-grant \
  --region us-west-2 \
  --key-id arn:aws:kms:us-west-2:444455556666:key/1a2b3c4d-5e6f-1a2b-3c4d-5e6f1a2b3c4d \
  --grantee-principal arn:aws:iam::111122223333:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling \
  --operations "Encrypt" "Decrypt" "ReEncryptFrom" "ReEncryptTo" "GenerateDataKey" "GenerateDataKeyWithoutPlaintext" "DescribeKey" "CreateGrant"

KMS key Policy to allow and access autoscaling group
=====================================================
  {
  	"Version": "2012-10-17",
  	"Id": "key-consolepolicy-3",
  	"Statement": [
  		{
  			"Sid": "Enable IAM User Permissions",
  			"Effect": "Allow",
  			"Principal": {
  				"AWS": "arn:aws:iam::041445559784:root"
  			},
  			"Action": "kms:*",
  			"Resource": "*"
  		},
  		{
  			"Sid": "Allow access for Key Administrators",
  			"Effect": "Allow",
  			"Principal": {
  				"AWS": "arn:aws:iam::041445559784:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
  			},
  			"Action": [
  				"kms:Create*",
  				"kms:Describe*",
  				"kms:Enable*",
  				"kms:List*",
  				"kms:Put*",
  				"kms:Update*",
  				"kms:Revoke*",
  				"kms:Disable*",
  				"kms:Get*",
  				"kms:Delete*",
  				"kms:TagResource",
  				"kms:UntagResource",
  				"kms:RotateKeyOnDemand"
  			],
  			"Resource": "*"
  		},
     {
       "Sid": "AllowASGToPerformCryptoOperationsAndGrants",
       "Effect": "Allow",
       "Principal": {
         "AWS": "arn:aws:iam::041445559784:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
       },
       "Action": [
         "kms:Encrypt",
         "kms:Decrypt",
         "kms:ReEncryptFrom",
         "kms:ReEncryptTo",
         "kms:GenerateDataKey",
         "kms:GenerateDataKeyWithoutPlaintext",
         "kms:DescribeKey",
         "kms:CreateGrant"
       ],
       "Resource": "*"
     }
  	]
  }
