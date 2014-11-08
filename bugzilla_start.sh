#!/bin/bash
# docker run -d -t --privileged \
#     --name bugzilla \
#     --hostname bugzilla \
#     --publish 8080:80 \
#     --publish 2222:22 \
#     --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
#     dklawren/docker-bugzilla 

docker build -rm -t romanlv/docker-testopia .

docker rm -f testopia 
docker run -d -t \
    --name testopia \
    --link mysql:db \
    -v $(pwd):/config \
    --hostname testopia \
    --publish 3000:80 \
    romanlv/docker-testopia


docker exec -it testopia bash

docker run -d -p 3307:3306 -e MYSQL_PASS="bugs" --name mysql tutum/mysql
