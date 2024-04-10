## Launch an Amazon Linux EC2
**Install Docker**
- **`apt update && yum install docker`**

**start Docker**
- **`service docker start`**


## Install Jenkins
```
docker run -d -p 8080:8080 -p 50000:50000 \
-v jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
jenkins/jenkins:lts
```


## Enter as root into Jenkins container and modify docker.sock permission
- **`docker exec -u 0 -it <container-id> bash`**
- **`chmod 666 /var/run/docker.run`**


## Enter as root into Jenkins container and [install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- **`docker exec -u 0 -it <container-id> bash`**
- **`apt-get update && sudo apt-get install -y gnupg software-properties-common`**
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
- **`apt update`**
- **`apt-get install terraform`**



