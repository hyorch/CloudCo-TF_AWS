pipeline {
    agent any

    stages {
        stage('Show Version') {
            steps {
                sh 'terraform version'
            }
        }
    }
}