pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'anukalpthakur'
        IMAGE_NAME = 'portfolio-site'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/anukalpthakur/portfolio-assests.git'
            }
        }

        stage('Debug Workspace') {
            steps {
                bat 'cd'
                bat 'dir'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKERHUB_USER%/%IMAGE_NAME%:latest .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                bat 'docker push %DOCKERHUB_USER%/%IMAGE_NAME%:latest'
            }
        }

        stage('Run Container Locally') {
            steps {
                bat 'docker stop portfolio || exit 0'
                bat 'docker rm portfolio || exit 0'
                bat 'docker run -d --name portfolio -p 9090:80 %DOCKERHUB_USER%/%IMAGE_NAME%:latest'
            }
        }
    }
}
