#!/bin/bash
gittag=$(git log -1 --pretty=%h)
docker tag jenkins:$gittag public.ecr.aws/y2a9o9h4/jenkins:$gittag
docker push public.ecr.aws/y2a9o9h4/jenkins:$gittag