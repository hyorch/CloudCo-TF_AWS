pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                sh 'aws s3 ls'
            }
        }
    }
}