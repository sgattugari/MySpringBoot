* Install Jenkins - https://docs.aws.amazon.com/aws-technical-content/latest/jenkins-on-aws/installation.html
* start jenkins - sudo service jenkins start
* Install git - sudo yum install git -y
* install maven - sudo yum install maven -y
* Prepare jenkinsfile
* Create webhook - http://<jenkins_instance>/github-webhook
* Install docker - sudo amazon-linux-extras install docker
* Give jenkins permission to docker by adding jenkins to docker group- sudo usermod -aG docker jenkins
* Restart jenkins - sudo service jenkins start
* Install AWS Commandline on jenkins
```
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -pv $HOME/bin
cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
aws-iam-authenticator help

```
