#!/bin/bash
# images: jenkinsci/blueocean  jenkins/jenkins:lts
# -v /var/jenkins_home:/var/jenkins_home \
#docker run --name jenkins \ -d \ -p 8080:8080 \ -p 50000:50000 \ --restart 
#always \ jenkins/jenkins:lts
#  -v /e/data/jenkins_home:/var/jenkins_home \
#  -v /e/data/jenkins_home/docker.sock:/var/run/docker.sock \

docker run \
  --name docker-jenkins \
  -u root \
  --rm \
  -p 8090:8080 \
  -p 50001:50000 \
  jenkinsci/blueocean