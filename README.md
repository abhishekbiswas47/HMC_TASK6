# HMC_TASK6
### Task Description
Deploy the Wordpress application on Kubernetes and AWS using terraform including the following steps;

1. Write an Infrastructure as code using terraform, which automatically deploy the Wordpress application
2. On AWS, use RDS service for the relational database for Wordpress application.
3. Deploy the Wordpress as a container either on top of Minikube or EKS or Fargate service on AWS
4. The Wordpress application should be accessible from the public world if deployed on AWS or through workstation if deployed on Minikube.

Try each step first manually and write Terraform code for the same to have a proper understanding of workflow of task.
### What is RDS?

Amazon Relational Database Service is a distributed relational database service by Amazon Web Services. Amazon RDS supports an array of database engines to store and organize data and helps with database management tasks.

### What is Kubernetes?

~Kubernetes is an open-source container platform that eliminates many of the manual processes involved in deploying and scaling containerized applications.

~If you are optimizing app development for the cloud is that it gives you the platform to schedule and run containers on clusters of physical or virtual machines (VMs).

### Prerequisite
•AWS account

•Minikube (as I am going to perform over minikube)

•Terraform tool
## Let's Get Started ......
#### Step 1 : 
Write an Infrastructure as code using Terraform, which automatically deploys the WordPress application.

main.tf file-:

```
          resource "null_resource" "minikubeservice" {
	  provisioner "local-exec" {
	    command = "minikube service list"
	    
	  }
	  depends_on = [
	      kubernetes_deployment.abhipress,
	      kubernetes_service.abhilb,
	      aws_db_instance.abhidb
	 
	     ]
	}
```
#### Step 2 :
Now we will write wordpress.tf

```
resource "kubernetes_deployment" "abhipress" {
 metadata {
  name = "wordpressapplication"
 }
spec {
 replicas = 3
 selector {
  match_labels = {
   env = "production"
   region = "IN"
   App = "wordpress"
  }
  match_expressions {
   key = "env"
   operator = "In"
   values = ["production" , "webserver"]
  }
 }
 template {
  metadata {
   labels = {
    env = "production"
    region = "IN"
    App = "wordpress"
   }
  }
  spec {
   container {
    image = "wordpress"
    name = "wordpress1" 
    }
   }
  }
 }
}
resource "kubernetes_service" "abhilb" {
 metadata {
  name = "abhilb"
 }
 spec {
  selector = {
   app = "wordpress"
  }
  port {
   protocol = "TCP"
   port = 80
   target_port = 80
  }
  type = "NodePort"
 }
}
```
#### Step 3 :
Use RDS service for the relational database for Wordpress application.

Now we should write terraform code for MySQL rds that creates MySQL database using rds.

```
provider "aws"{
region="ap-south-1"
}
resource "aws_db_instance" "abhidb" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.30"
  instance_class       = "db.t2.micro"
  name                 = "dbs"
  username             = "Abhishek"
  password             = "Abhishek123"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible  =true
  iam_database_authentication_enabled = true


tags={
 Name="wordpresssqldb"
}
}
}
``` 
#### Step 4 : 
To use our terraform code first we have to initialize it by using this command-:
```
terraform init
```
```
terraform validate
```
after that we have to run this command and the terraform will perform the task.
```
terraform apply --auto-approve
```
It will print url for getting wordpress dashboard and rdb ip so that we can connect the wordpress and rdb .

to destroy the environment created above we ca use the command-:

```
terraform destroy --auto-approve
```
