pipeline {
    environment {
        DOCKERHUB_CREDENTIALS = credentials("DHubCred")
    }
    agent {
        label 'j-slave'
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('git-clone') {
            steps {
                git branch: 'main', url: 'https://github.com/shahfahed/Project-2.git'
            }
        }

        stage('docker-buid-publish') {
            steps {
                sh 'docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}'
                sh 'docker build --file Dockerfile --tag shahfahed/project-2:$BUILD_NUMBER .'
                SH 'docker push shahfahed/project-2:$BUILD_NUMBER'
            }
        }

        stage('deploy on k8s') {
            steps {
                sh 'ansible-playbook playbook-deploy.yaml -u ubuntu --extra-vars "tag=$BUILD_NUMBER"'
            }
        }
    }
}