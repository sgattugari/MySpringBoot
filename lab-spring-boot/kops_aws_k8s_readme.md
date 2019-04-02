# To set up K8S environment
````
./setup_kops_aws_k8s_env.sh
````
# To host containers on this env:
## Create docker registry
Create ECR(Elastic Container Registry)on aws.amazon.com or through aws cli
## Create image in local machine
````
mvn clean && mvn install
````
### Start docker machine by starting minikube
````
minikube start
eval $(minikube docker-env)
````
## Push image to docker registry

## Create user to access IAM and add the following policies - 
 * * AmazonEC2ContainerRegistryFullAccess
 * * AmazonEC2ContainerRegistryPowerUser
 * * AmazonEC2ContainerRegistryReadOnly
### Give user access to ECR
 * * Open ECR instance in AWS Console and give appropriate permissions to the new user
### Login to AWS ECR
```
aws configure (Set users access key and secret access key from AWS console for that user)
aws ecr get-login --no-include-email --region us-west-2

```
### Build docker image
docker build -t myspringboot .
### Tag image
docker tag myspringboot:latest 961578000206.dkr.ecr.us-west-2.amazonaws.com/myspringboot:latest
### Push image
docker push 961578000206.dkr.ecr.us-west-2.amazonaws.com/myspringboot:latest
### Deploy k8s image - create pods
#### Edit the kubernetes/deployment.yaml with the docker registry/image name
#### Deploy containers/pods 
````
kubectl apply -f kubernetes/deployment.yaml
````
#### Create k8s service
````
kubectl apply -f kubernetes/service.yaml
````
Allow access to the service port on the EC2 nodes' security group to allow access to the application. 
