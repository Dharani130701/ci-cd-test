pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-python-wsgi-app'
        APP_CONTAINER = 'python-wsgi-container'
        APP_PORT = '5000'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'new', url: 'https://github.com/Dharani130701/ci-cd-test.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    #!/bin/bash
                    docker build -t ${IMAGE_NAME} .
                '''
            }
        }

        stage('Run App Container') {
            steps {
                sh '''
                    #!/bin/bash
                    docker rm -f ${APP_CONTAINER} 2>/dev/null || echo "Container not found"
                    docker run -d -p ${APP_PORT}:${APP_PORT} --name ${APP_CONTAINER} ${IMAGE_NAME}
                '''
            }
        }
    }

    post {
        success {
            echo "✅ App container deployed successfully."
        }
        failure {
            echo "❌ Pipeline failed. Please check the logs."
        }
    }
}
