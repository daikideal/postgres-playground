#!/bin/sh
#
# requirements:
#  - docker
#  - psql
#
# usage:
#  ./login.sh
#

imageName="postgres-playground"

containerId=$(docker ps | grep $imageName | awk '{print $1}')

username="postgres"

# NOTE: playgroundなのでパスワードは設定していない
docker exec -it "$containerId" psql -U $username
