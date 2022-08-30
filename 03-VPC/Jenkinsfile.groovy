pipeline {
    agent any
    environment{
        ENV_FILENAME = ""
    }
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
                            ENV_FILENAME = "develop_vars.tfvars"                       
                            break
                        default:
                            ENV_FILENAME = "no_file.txt"
                            break
                    }
                }
                echo env_filename
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
                sh 'terraform init -var-file ${env.ENV_FILENAME} -backend-config="key=03-VPC-${ENV_NAME}/terraform.tfstate"'
                echo "End Terraform Init"
            }
        }

        
        stage('Terraform Plan') {
            when { anyOf{environment name: 'ACTION', value: 'plan';}}
            steps {
                sh 'terraform plan -var-file ${env.ENV_FILENAME}'
                echo "End Terraform Plan"
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



    }
}