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
                sh 'docker build -t mdaakhil/maven-web-application .'
            }
        }

        stage('docker login') {
            steps {
              sh 'docker login -u mdaakhil -p dckr_pat_kXDrusXZjYW0b47KyeTuNNb32K8'
                }
            }
        stage('docker push') {
            steps {
              sh 'docker build -t mdaakhil/maven-web-application:1 .'
                }
            }
        }
    }
