#!/bin/bash
gittag=$(git log -1 --pretty=%h)
aws ecr-public get-login-password --region us-east-1 
docker login --username AWS --password-stdin public.ecr.aws/y2a9o9h4
docker build -t check .
docker tag check:latest public.ecr.aws/y2a9o9h4/check:$gittag
docker push public.ecr.aws/y2a9o9h4/check:$gittag
