## Launch an Amazon Linux EC2 (add port 8080 in inbound rules)
**Install Docker**
```
yum update && yum install docker
```

**start Docker**
```
service docker start
```


## Install Jenkins
```
docker run -d -p 8080:8080 -p 50000:50000 \
-v jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
jenkins/jenkins:lts
```


## Initial admin password
```
docker exec -it <container-id> /bin/bash
```
```
cat /var/jenkins_home/secrets/initialAdminPassword
```



## Enter as root into Jenkins container and modify docker.sock permission
```
docker exec -u 0 -it <container-id> /bin/bash
```
```
chmod 666 /var/run/docker.sock
```


## Enter as root into Jenkins container and [install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
```
docker exec -u 0 -it <container-id> /bin/bash
```
```
apt install wget
```
```
apt-get update && apt-get install -y gnupg software-properties-common
```
```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```
```
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
tee /etc/apt/sources.list.d/hashicorp.list
```
```
apt update
```
```
apt-get install terraform
```


## Create key-pair for EC2 which will be used by Terraform to connect to created instance for our


## Add Credentials in Jenkins
- **As Secret text for docker-hub and AWS Credentials, SSH username with private key for key-pair (username as `ec2-user`)**
![credentials in jenkins](https://github.com/anshu049/CI-CD-Pipeline-Setup-for-Dockerized-Application-on-AWS-EC2-with-Terraform/assets/95365748/2e75a587-07e8-4d17-9fbb-4b8937d24948)

