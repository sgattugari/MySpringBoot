pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')        
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "Build initialized by $(whoami)"
                    java -version
                    mvn --version
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                ''' 
            }
        }
        stage('Build') {
            steps {
                echo 'Building jar..'
                sh 'mvn -Dmaven.test.failure.ignore=true install'
            }
        }
        stage('DeployDockerImage') {
            steps{
                sh '''
                    echo 'Declare Tag var'
                    TAG_ID=$(git log -1 --pretty=%h)
                    echo 'AWS Configure'
                    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                    echo 'Login to ECR'
                    $(aws ecr get-login --no-include-email --region us-east-1)
                    echo 'Docker Build for ECR'
                    docker build -t myspringboot:$TAG_ID .
                    echo 'Docker tag image'
                    docker tag myspringboot:$TAG_ID 961578000206.dkr.ecr.us-east-1.amazonaws.com/myspringboot:$TAG_ID
                    echo 'Docker push'
                    docker push 961578000206.dkr.ecr.us-east-1.amazonaws.com/myspringboot:$TAG_ID
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
