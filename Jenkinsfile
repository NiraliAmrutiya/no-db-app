pipeline {
    agent any
    tools {
        maven 'maven-3.9.9'
    }

    stages {
        stage("Maven Clean"){
            steps{
                echo 'Maven Clean Started'
                sh 'mvn clean'
            }
        }
        stage('Maven Compile') {
            steps {
                echo 'Maven Compile Started'
                sh 'mvn compile'
            }
        }
        stage('Maven Test') {
            steps {
                echo 'Maven test'
                sh 'mvn test'
            }
        }
        
        // stage('SonarQube Analysis') {            
        //     steps {
        //         withSonarQubeEnv('SonarQube') { 
        //           echo 'SonarQube Analysis Started' 
        //           sh "mvn clean verify sonar:sonar -Dsonar.projectKey=no-db-app -Dsonar.projectName=no-db-app"
        //         }
        //     }
        // }

        // stage('Push Artifact to Nexus') {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'adminUserNexus', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        //             echo 'Maven Deploy Started'
                    
        //             sh "export APP_VERSION='1.0.0' && mvn deploy --settings ./.mvn/local-settings.xml"
        //         }
        //     }
        // }
        
        stage('Publish Artifact') {
            steps {
                sh "export APP_VERSION='1.0.1' && mvn package"
            }
        }
        
        stage('CD - Push artifact to ec2') {
            
            steps {
                withCredentials([file(credentialsId: 'no-db-app-ec2-key.pem', variable: 'secretFile')]) {
                    sh '''#!/bin/bash
                    
                    export APP_VERSION='1.0.1'
                    echo $APP_VERSION
                    
                    ls
                    
                    echo "Transferring JAR to EC2..."
                    scp -i $secretFile ./target/no-db-app-$APP_VERSION.jar ec2-user@ec2-54-162-152-171.compute-1.amazonaws.com:/home/ec2-user/no-db-app/
                    scp -i $secretFile ./deploy.sh ec2-user@ec2-54-162-152-171.compute-1.amazonaws.com:/home/ec2-user/no-db-app/

                    echo "Verifying JAR on remote server..."
                    ssh -i $secretFile ec2-user@ec2-54-162-152-171.compute-1.amazonaws.com "ls -lh /home/ec2-user/no-db-app/no-db-app-$APP_VERSION.jar && file /home/ec2-user/no-db-app/no-db-app-$APP_VERSION.jar"
                    
                    echo "check port 8080"
                    ssh -i $secretFile ec2-user@ec2-54-162-152-171.compute-1.amazonaws.com "sudo lsof -i :8080"
                    
                    echo "Print PID"
                    ssh -i $secretFile ec2-user@ec2-54-162-152-171.compute-1.amazonaws.com "sudo lsof -i :8080 -t"
                        
                    echo "identify process on 8080, kill it and restart the app"
                    ssh -i $secretFile ec2-user@ec2-54-162-152-171.compute-1.amazonaws.com "deploy.sh $APP_VERSION"
                    '''
                }
            }
        }
    }
}
