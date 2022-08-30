def tfvars_filename = "no-tfvars.txt"
def tfstate_file = "no-tfstate.txt"

pipeline {
    agent any
    
    parameters {
		choice (name: 'ENV_NAME',
				choices: ['dev','qa','preprod','prod'],
				description: 'Environment')	
		choice (name: 'ACTION',
				choices: [ 'plan', 'apply', 'destroy'],
				description: 'Run terraform plan / apply / destroy')		
    }

    options {
        // This is required if you want to clean before build
        skipDefaultCheckout(true)
    }

    stages {

        stage('Init Parameters') {
            steps{                
                script {
                    switch(params.ENV_NAME) {
                        case "dev":                               
                            tfvars_filename = "develop_vars.tfvars"    
                            tfstate_file = "key=03-VPC-${ENV_NAME}/terraform.tfstate" 
                            break
                        default:
                            tfvars_filename = "no_file.txt"
                            tfstate_file = "no_tfstate.txt"
                            break
                    }
                }
                echo "Files: ${tfvars_filename} ${tfstate_file}"
                
            }
        }

        stage('Init Workspace') {            
            steps {
                cleanWs()
                checkout scm
            }
        }

        stage('Terraform Init') {            
            steps {
                echo "file: ${tfvars_filename}  ${tfstate_file}"
                
                pwd()
                dir('03-VPC'){
                    sh "terraform init -no-color -var-file ${tfvars_filename} -backend-config='${tfstate_file}'"
                    sh "ls -l"
                }
                sh "ls -l"
                echo "End Terraform Init"
            }
        }

        
        stage('Terraform Plan') {
            when { 
                anyOf{
                    environment name: 'ACTION', value: 'plan';
                    environment name: 'ACTION', value: 'apply';
                }
            }
            steps {
                dir('03-VPC'){
                    sh "terraform plan -no-color -var-file ${tfvars_filename}"                    
                }                
                echo "**************End Terraform Plan******************************"
            }
        }

        stage('Approval') {
            when { 
                anyOf{
                    environment name: 'ACTION', value: 'apply';
                    environment name: 'ACTION', value: 'destroy';
                }
            }
            steps {
                input(id:'confirm',message: 'Click "proceed" to show Terraform Version')
            }
        }
        stage('Terraform Apply') {
            when { anyOf{environment name: 'ACTION', value: 'apply';}}
            steps {
                dir('03-VPC'){
                    sh "terraform apply -no-color -var-file ${tfvars_filename} --auto-approve"                    
                }                
                echo "**********************End Terraform Plan*********************"
            }
        }
        stage('Terraform Destroy') {
            when { anyOf{environment name: 'ACTION', value: 'destroy';}}
            steps {
                dir('03-VPC'){
                    sh "terraform destroy -no-color -var-file ${tfvars_filename} --auto-approve"                    
                }                
                echo "*************End Terraform Destroy**************"
            }
        }



    }
}