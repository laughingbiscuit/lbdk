# Jenkins All-in-one


```
docker run -itd --name=some-jenkins -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
export ADMIN_PASS=$(docker exec -it some-jenkins cat /var/jenkins_home/secrets/initialAdminPassword)
```

## install plugins
```
docker exec -it some-jenkins bash -c "install-plugins.sh github:latest maven-plugin:latest"
```

## Check the Job Queue

```
curl http://localhost:8080/queue/api/json?pretty=true -u admin:curl http://localhost:8080/queue/api/json?pretty=true -u admin:$ADMIN_PASS
```
