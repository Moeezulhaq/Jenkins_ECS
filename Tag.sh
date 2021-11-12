#!/bin/bash
gittag=$(git log -1 --pretty=%h)
aws ecr-public get-login-password --region us-east-1 
docker login --username AWS --password-stdin public.ecr.aws/y2a9o9h4
docker build -t jenkins .
docker tag jenkins:latest public.ecr.aws/y2a9o9h4/jenkins:$gittag
docker push public.ecr.aws/y2a9o9h4/jenkins:$gittag
