# VARS AND BACKEND
Run Terraform pointing to a configuration tfvars file.

```bash
terraform init -var-file ireland_vars.tfvars 
terraform plan -var-file ireland_vars.tfvars 
terraform apply -var-file ireland_vars.tfvars 
```

To customize S3 folder for environment
```bash
terraform init -var-file ireland_vars.tfvars -backend-config="key=folder/terraform.tfstate"
```

terraform apply --auto-approve
