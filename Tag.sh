#!/bin/bash
gittag=$(git log -1 --pretty=%h)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 489994096722.dkr.ecr.us-east-1.amazonaws.com
docker build -t ecs-jenkins .
docker tag ecs-jenkins:latest 489994096722.dkr.ecr.us-east-1.amazonaws.com/ecs-jenkins:$gittag
docker push 489994096722.dkr.ecr.us-east-1.amazonaws.com/ecs-jenkins:$gittag
sed -i "s/latest/$gittag/g" ecs.yml


# docker build -t jenkins-ecs .
# docker tag jenkins-ecs:latest public.ecr.aws/y2a9o9h4/jenkins-ecs:$gittag
# docker push public.ecr.aws/y2a9o9h4/jenkins-ecs:$gittag
# sed -i "s/latest/$gittag/g" ecs.yml

