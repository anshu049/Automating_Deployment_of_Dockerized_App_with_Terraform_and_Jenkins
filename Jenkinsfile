pipeline {
    agent any

    environment {
        IMAGE_NAME = 'anshu049/tweet-app'
        DOCKER_CREDS_USR = credentials('docker-hub-username')
        DOCKER_CREDS_PSW = credentials('docker-hub-password')
        AWS_ACCESS_KEY_ID = credentials('access_key')
        AWS_SECRET_ACCESS_KEY = credentials('secret_access_key')
        SSH_KEY_CREDENTIAL = 'server-ssh-key'
    }

    stages {
        stage('checkout code') {
            steps {
                echo 'Checking out code...'
                git branch: 'master', url: 'https://github.com/anshu049/CI-CD-Pipeline-Setup-for-Dockerized-Application-on-AWS-EC2-with-Terraform'
            }
        }

        stage('build image') {
            steps {
                echo 'Building docker image...'
                sh "docker build -t ${IMAGE_NAME} ."
                dockerLogin()
                dockerPush(env.IMAGE_NAME)
            }
        }

        stage('provision server') {
            environment {
                TF_VAR_env_prefix = 'test'
            }
            steps {
                script {
                    withCredentials([string(credentialsId: 'access_key', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'secret_access_key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        dir('terraform') {
                            sh "terraform init"
                            sh "terraform destroy --auto-approve"
                            EC2_PUBLIC_IP = sh(script: "terraform output ec2_public_ip", returnStdout: true).trim()
                        }
                    }
                }
            }
        }

        stage('deploy') {
            steps {
                script {
                    echo "Waiting for EC2 server to initialize" 
                    sleep(time: 90, unit: "SECONDS") 

                    echo 'Deploying docker image to EC2...'
                    echo "${EC2_PUBLIC_IP}"

                    sshagent(['server-ssh-key']) {
                        sh "scp -o StrictHostKeyChecking=no server-cmds.sh ec2-user@${EC2_PUBLIC_IP}:/home/ec2-user"
                        sh "ssh ec2-user@${EC2_PUBLIC_IP} bash /home/ec2-user/server-cmds.sh"
                    }
                }
            }
        }
    }
}

def dockerLogin() {
    sh "echo ${DOCKER_CREDS_PSW} | docker login -u ${DOCKER_CREDS_USR} --password-stdin"
}

def dockerPush(imageName) {
    sh "docker push ${env.IMAGE_NAME}"
}
