pipeline {
    agent any
    tools {
        maven 'maven-3.9.9'
    }

    stages {
        stage("Maven Clean"){
            steps{
                echo 'maven cleaning'
                sh 'mvn clean'
            }
        }
        stage('Maven Compile') {
            steps {
                echo 'maven compiling'
                sh 'mvn compile'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') { // Replace with the name you configured in Jenkins
                    sh 'sonar-scanner' // Or your specific scanner command
                }
            }
        }
    
        stage('Maven Deploy') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'adminUserNexus', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    echo 'maven deploying'
                    echo "USERNAME = $USERNAME"
                    echo "PASSWORD = $PASSWORD"
                    sh "export APP_VERSION='1.0.1' && mvn deploy --settings ./.mvn/local-settings.xml"
                }
            }
        }
    }
}
