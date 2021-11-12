#!/bin/bash
gittag=$(git log -1 --pretty=%h)
docker build -t jenkins:$gittag .
docker tag jenkins:$gittag public.ecr.aws/y2a9o9h4/jenkins:$gittag
docker push public.ecr.aws/y2a9o9h4/jenkins:$gittag
aws ecr-public get-login-password --region us-east-1 
docker login --username AWS --password-stdin public.ecr.aws/y2a9o9h4