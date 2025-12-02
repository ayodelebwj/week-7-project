pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials ('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials ('aws-secret-access-key')
        AWS_DEFAULT_REGION = 'us-east-2'
    }
    
    stages {
        stage ('checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/ayodelebwj/week-7-project.git'
            }
        }
        stage ('Build Packer AMIs') {
           steps {
            dir ('jenkins-files/create-ami') {
                script {
                    load 'Jenkinsfile'
                }
             }
          }
        }

         stage ('Create Terraform Infrastructure') {
           steps {
            dir ('jenkins-files/build-infrastructure') {
                script {
                    load 'Jenkinsfile'
                }
                

             }
          }
        }

         stage ('Deploy Nginx Fruit-Veg Web Server') {
           steps {
            dir ('jenkins-files/deploy-web') {
                script {
                    load 'Jenkinsfile'
                }
             }
          }
        }
    }
}