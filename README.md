## Launch an Amazon Linux EC2
**Install Docker**
-**`apt update && yum install docker
**start Docker**
-**`service docker start`**


## Install Jenkins
```
docker run -d -p 8080:8080 -p 50000:50000 \
-v jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
jenkins/jenkins:lts
```
## enter as root into Jenkins container and modify docker.sock permission
- **`docker exec -u 0 -it 0c73a1692b75 bash`**
- **`chmod 666 /var/run/docker.run`**
