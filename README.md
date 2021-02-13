# S3_CloudFront_Webdeployment
Secure static website dynamically deploy it with Terraform hosted in AWS

###### Cloud - :cloud:
![AWS](https://img.shields.io/badge/-AWS-000000?style=flat&logo=Amazon%20AWS&logoColor=FF9900)

###### IaaC
![Terraform](https://img.shields.io/badge/-Terraform-000000?style=flat&logo=Terraform)

## Note

module.stactic_web will be creating resource such aws cloudfront distribution for an S3 bucket with web static files.
module.dns will be creating resource such aws cloudfront origin OAI for an S3 bucket with web static files.

Proper security policies for S3 buckets and CloudFront are still require in both deployments. This would depend in use case.
# Purpose

Shows how to use AWS with Terraform to accomplish the following tasks:

* Create one or multiple S3 buckets to storage/host static web files 
* Create a CloudFront for a fast content delivery network (CDN)
# Prerequisites

* You must have an AWS account, and have your default credentials and AWS Region
  configured
* You must have Terraform installed
# Cautions

* As an AWS best practice, grant this code least privilege, or only the 
  permissions required to perform a task. For more information, see 
  [Grant Least Privilege](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege) 
  in the *AWS Identity and Access Management 
  User Guide*.
* This code has been tested in us-east-1 AWS Regions only. However it should work in any other region. 
* Running this code might result in charges to your AWS account.

# How to run this code
* Clone this repo
* cd to S3_CloudFront_Webdeployment folder
* terraform init
* terraform plan
* terraform validate
* terraform apply
* Alternate command : terraform apply -auto-approve
* terraform destroy
* Alternate command : terraform destroy -auto-approve
* terraform fmt # A way to format the terraform code