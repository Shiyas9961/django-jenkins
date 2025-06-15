pipeline {
    agent {
        label "dev"
    }

    stages {
        stage("Clone") {
            steps {
                git url: "https://github.com/Shiyas9961/django-jenkins.git",
                branch: "main"
            }
        }
        stage("Build"){
            steps {
                sh "docker compose build --no-cache"
            }
        }
        stage("Push"){
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    sh "docker tag travel_app:latest $DOCKER_USERNAME/travel_app:latest"
                    sh "docker compose push $DOCKER_USERNAME/travel_app:latest"
                }
            }
        }
        stage("Deploy"){
            steps {
                sh "docker-compose up -d"
            }
        }
    }
}