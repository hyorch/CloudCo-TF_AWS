# CloudCo company IaC with Terraform.

Demo example to build an AWS infraestructure for a company using Terraform.  
We will deploy a Jenkins server from our local machine in the default VPC and then we will build a new VPC using Jenkins jobs.
For this demo, we are using just one AWS account instead of separating environments in different accounts.

Follow this steps to build CloudCo Cloud Infra.

0. Configure local AWS credentials
```bash
aws configure
```

1. Create S3 bucket and DynomoDB table for Terraform backend. Deploy Terraform block "01-S3_Bucket".

2. Create Jenkins server on default VPC, enabling Internet access and attaching needed roles for further steps.  
Check Terraform and AWS Cli using demos jobs in "02-Jenkins\Jobs" folder. For this demo, we will run Jenkins jobs using the server as agent.

3. Run Jenkins job to Create and modify VPC. 
    - Create a job from SCM Git repo. (As this is a demo, we will use just one branch, main, for all evironments. No credentials are required)
        - Script Path: 03-VPC/Jenkinsfile.groovy
        - Branch: */main
        - Repository: https://github.com/hyorch/CloudCo-TF_AWS

4. Create WebServer on new VPC. Query VPC id from remote status before create EC2 instance.
    
