#!/bin/bash

set -e

account=$(aws sts get-caller-identity --query='UserId' --output=text)
login_cmd=$(aws ecr get-login --no-include-email --region ap-northeast-1)

docker build -t illaoi .
docker tag illaoi:latest ${account}.dkr.ecr.ap-northeast-1.amazonaws.com/illaoi:latest
eval ${login_cmd}
docker push ${account}.dkr.ecr.ap-northeast-1.amazonaws.com/illaoi:latest
