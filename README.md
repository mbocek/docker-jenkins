Jenkins
============

Docker recipe for jenkins customized container.

Run jenkins image which use data image: 
```
sudo docker run -d -m=512m --name jenkins -p 8081:8080 --volumes-from jenkins-data mbocek/jenkins:latest
```