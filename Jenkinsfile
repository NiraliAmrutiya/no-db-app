pipeline {
    agent any
    tools {
        maven 'maven-3.9.9'
    }

    stages {
        stage("Maven Clean"){
            steps{
                echo 'Maven cleaning'
                sh 'mvn clean'
            }
        }
        stage('Maven Compile') {
            steps {
                echo 'Maven compiling'
                sh 'mvn compile'
            }
        }
        stage('Maven Test') {
            steps {
                echo 'Maven test'
                sh 'mvn test'
            }
        }
        
        stage('SonarQube Analysis') {            
            steps {
                withSonarQubeEnv('SonarQube') { 
                   echo 'SonarQube Analysis Started' 
                   sh "mvn clean verify sonar:sonar -Dsonar.projectKey=no-db-app -Dsonar.projectName=no-db-app"
                }
            }
        }
    
        stage('Maven Deploy') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'adminUserNexus', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    echo 'Maven deploying'
                    echo "USERNAME = $USERNAME"
                    echo "PASSWORD = $PASSWORD"
                    sh "export APP_VERSION='1.0.1' && mvn deploy --settings ./.mvn/local-settings.xml"
                }
            }
        }
    }
}
