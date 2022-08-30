pipeline {
    agent any
      environment{
        env_filename = ""
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
                            env_filename = "develop_vars.tfvars"                       
                            break
                        default:
                            env_filename = "no_file.txt"
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
                sh 'terraform init -var-file ${env_filename} -backend-config="key=${params.ENV_NAME}/terraform.tfstate"'
                echo "End Terraform Init"
            }
        }

        
        stage('Terraform Plan') {
            when { anyOf{environment name: 'ACTION', value: 'plan';}}
            steps {
                sh 'terraform plan -var-file ${env_filename}'
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