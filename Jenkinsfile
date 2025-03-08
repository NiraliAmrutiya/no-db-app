pipeline {
    agent any
    tools {
        maven 'maven-3.9.9'
    }

    environment {
        APP_VERSION = '1.0.0'
        NEXUS_USERNAME = 'admin'
        NEXUS_PASSWORD = 'admin'
    }
    
    stages {
        stage('Maven Compile') {
            steps {
                echo 'maven compiling'
                sh 'mvn compile'
            }
        }
        stage('Maven Deploy') {
            steps {
                echo 'maven deploying'
                echo 'NEXUS_USERNAME = ${NEXUS_USERNAME}'
                echo 'NEXUS_PASSWORD = $NEXUS_PASSWORD'
                sh 'mvn deploy --settings ./.mvn/local-settings.xml'
            }
        }
    }
}
