pipeline {
    agent any
    tools {
        maven 'maven-3.9.9'
    }

    environment {
        APP_VERSION = '1.0.0'
        NEXUS_USERNAME = 'no-db-app-maven-user'
        NEXUS_PASSWORD = 'admin'
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
        stage('Maven Deploy') {
            steps {
                echo 'maven deploying'
                echo "NEXUS_USERNAME = $NEXUS_USERNAME"
                echo "NEXUS_PASSWORD = $NEXUS_PASSWORD"
                sh "export NEXUS_USERNAME='no-db-app-hosted-user' && export APP_VERSION='1.0.1' && export NEXUS_PASSWORD='admin' && mvn deploy --settings ./.mvn/local-settings.xml"
            }
        }
    }
}
