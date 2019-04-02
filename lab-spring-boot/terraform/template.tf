provider "aws" {}
resource "aws_instance" "lab" {
    ami = "ami-1e299d7e"
    instance_type = "t2.micro"
    tags {
        Name = "lab"
    }
   key_name = "debashis1982-new"
    provisioner "file" {
      source = "../rootfs/etc/yum.repos.d/elasticsearch.repo"
      destination = "/tmp/elasticsearch.repo"
      connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("~/.ssh/debashis1982-new.pem")}"
      }
    }
    provisioner "remote-exec" {
        inline = [
          "sudo yum -y install java-1.8.0",
          "sudo yum -y remove java-1.7.0-openjdk",
          "sudo mv /tmp/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo",
	  "sudo yum -y install logstash",
        ]
         connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("~/.ssh/debashis1982-new.pem")}"
         }
    }
    provisioner "file" {
      source = "../rootfs/etc/logstash/conf.d/myspringboot.conf"
      destination = "/tmp/myspringboot.conf"
      connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("~/.ssh/debashis1982-new.pem")}"
      }
    }
    provisioner "file" {
      source = "../target/lab-spring-boot-0.1.0.jar"
      destination = "/tmp/lab-spring-boot-0.1.0.jar"
      connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("~/.ssh/debashis1982-new.pem")}"
      }
    }
    provisioner "remote-exec" {
        inline = [
          "sudo yum -y install java-1.8.0",
          "sudo yum -y remove java-1.7.0-openjdk",
          "chmod 755 /tmp/lab-spring-boot-0.1.0.jar",
          "sudo ln -s /tmp/lab-spring-boot-0.1.0.jar /etc/init.d/labjava",
          "sudo service labjava start",
          "sudo mv /tmp/myspringboot.conf /etc/logstash/conf.d/myspringboot.conf",
	  "echo 'starting logstash'",
          "sudo nohup /usr/share/logstash/bin/logstash --path.settings /etc/logstash > /tmp/logstash-start.log 2>&1 </dev/null &",
          "history",
          "ps -ef | grep logstash",
	  "echo 'started'"
        ]
         connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("~/.ssh/debashis1982-new.pem")}"
         }
    }
}
