pipeline {
    agent any

    tools {
        maven 'Maven3.8.2'
        jdk 'openJDK11'
    }

    environment {
        DOCKER_IMAGE = 'mdaakhil/maven-web-application:latest'
    }

    stages {
        stage('SCM') {
            steps {
                git url: 'https://github.com/Mraakhil/dockertheend.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('docker build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('docker push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }
    }
}
