provider "aws" {
	region = var.region
	access_key = var.access_key
	secret_key = var.secret_key
}   

#creating an instance for deploying tomcat and connecting it to tomcat_sg
resource "aws_instance" "tomcat-server" {
	ami = "ami-07625b74039b1a58b"
	instance_type = "t2.micro"
	key_name = "trail-key"
	security_groups = ["${aws_security_group.tomcat-sg.name}"]
	tags = {
		Name = "tomcat-server" 			
	}
}

#creating an SG group and assigining it to the tomcat-server instance
resource "aws_security_group" "tomcat-sg" {
	name = "tomcat-sg"
	ingress {
		cidr_blocks = ["99.227.118.13/32"]
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
	}
	egress {
		cidr_blocks = ["0.0.0.0/0"]
		from_port = 0
		to_port = 0
		protocol = "-1"
	}
	tags = {
		Name = "tomcat-sg"
	}
}

#creating an instance for deploying apache and connecting it to apache_sg
resource "aws_instance" "apache-web-server" {
	ami = "ami-07625b74039b1a58b"
	instance_type = "t2.micro"
	key_name = "trail-key"
	security_groups = ["${aws_security_group.apache-sg.name}"]
	tags = {
		Name = "apache-web-server" 			
	}
}

#creating an SG group and assigining it to the apache-web-server instance
resource "aws_security_group" "apache-sg" {
	name = "apache-sg"
	ingress {
		cidr_blocks = ["99.227.118.13/32"]
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
	}
	egress {
		cidr_blocks = ["0.0.0.0/0"]
		from_port = 0
		to_port = 0
		protocol = "-1"
	}
	tags = {
		Name = "apache-sg"
	}
}

#creating an instance for deploying active-directory and connecting it to active_directory_sg
resource "aws_instance" "active-directory" {
	ami = "ami-07625b74039b1a58b"
	instance_type = "t2.micro"
	key_name = "trail-key"
	security_groups = ["${aws_security_group.active_directory_sg.name}"]
	tags = {
		Name = "active-directory" 			
	}
}

#creating an SG group and assigining it to the active-directory instance
resource "aws_security_group" "active_directory_sg" {
	name = "active_directory_sg"
	ingress {
		cidr_blocks = ["99.227.118.13/32"]
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
	}
	egress {
		cidr_blocks = ["0.0.0.0/0"]
		from_port = 0
		to_port = 0
		protocol = "-1"
	}
	tags = {
		Name = "active_directory_sg"
	}
}

#creating an instance for deploying jboss-server and connecting it to jboss_sg
resource "aws_instance" "jboss-server" {
	ami = "ami-07625b74039b1a58b"
	instance_type = "t2.micro"
	key_name = "trail-key"
	security_groups = ["${aws_security_group.jboss_sg.name}"]
	tags = {
		Name = "jboss-server" 			
	}
}

#creating an SG group and assigining it to the jboss-server instance
resource "aws_security_group" "jboss_sg" {
	name = "jboss_sg"
	ingress {
		cidr_blocks = ["99.227.118.13/32"]
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
	}
	egress {
		cidr_blocks = ["0.0.0.0/0"]
		from_port = 0
		to_port = 0
		protocol = "-1"
	}
	tags = {
		Name = "jboss_sg"
	}
}

#creating an instance for deploying tomcat and connecting it to jenkins_slave_sg
resource "aws_instance" "jenkins-slave-terraform" {
	ami = "ami-07625b74039b1a58b"
	instance_type = "t2.micro"
	key_name = "trail-key"
	security_groups = ["${aws_security_group.jenkins_slave_sg.name}"]
	tags = {
		Name = "jenkins-slave-terraform" 			
	}
}

#creating an SG group and assigining it to the jenkins-slave-terraform instance
resource "aws_security_group" "jenkins_slave_sg" {
	name = "jenkins_slave_sg"
	ingress {
		cidr_blocks = ["99.227.118.13/32"]
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
	}
	egress {
		cidr_blocks = ["0.0.0.0/0"]
		from_port = 0
		to_port = 0
		protocol = "-1"
	}
	tags = {
		Name = "jenkins_slave_sg"
	}
}

#creating an instance for deploying tomcat and connecting it to jenkins_slave_sg
resource "aws_instance" "jenkins-slave-ansible" {
	ami = "ami-07625b74039b1a58b"
	instance_type = "t2.micro"
	key_name = "trail-key"
	security_groups = ["${aws_security_group.jenkins_slave_sg.name}"]
	tags = {
		Name = "jenkins-slave-ansible" 			
	}
}

#creating an ec2 instance for deploying docker into it
resource "aws_instance" "docker-deployment" {
	ami = "ami-07d95746fec4b20a3"
	instance_type = "t2.micro"
	key_name = "trail-key"
	security_groups = ["${aws_security_group.docker-sg.name}"]
	tags = {
		Name = "docker-deployment" 			
	}
}
#creating a subsequent security group for docker-deployment
resource "aws_security_group" "docker-sg" {
	name = "docker-sg"
	ingress {
		cidr_blocks = ["99.227.118.13/32"]
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
	}
	ingress {
		cidr_blocks = ["99.227.118.13/32"]
		from_port = 80
		to_port = 80
		protocol = "tcp"
	}
	ingress {
		cidr_blocks = ["99.227.118.13/32"]
		from_port = 22
		to_port = 22
		protocol = "tcp"
	}
	ingress {
		cidr_blocks = ["99.227.118.13/32"]
		from_port = 443
		to_port = 443
		protocol = "tcp"
	}
	egress {
		cidr_blocks = ["0.0.0.0/0"]
		from_port = 0
		to_port = 0
		protocol = "-1"
	}
	tags = {
		Name = "docker-sg"
	}
}


resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = "${aws_iam_role.lambda_role.id}"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1626203071503",
      "Action": "logs:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
  })
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

locals {
  lambda_zip_location = "outputs/hello-world.zip"
}

data "archive_file" "hello-world" {
  type        = "zip"
  source_file = "hello-world.py"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "${local.lambda_zip_location}"
  function_name = "hello-world"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "hello-world.hello"

  #source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "python3.7"
}


#resource for creating a S3 Bucket (prod-webdeploy-234564)
resource "aws_s3_bucket" "prod-webdeploy-234564" {
  bucket = "prod-webdeploy-234564"
  acl = "private"

  tags = {
    Name = "prod-webdeploy-234564"
  }
}

