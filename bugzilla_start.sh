# mysql container 
docker run -d -p 3307:3306 -e MYSQL_PASS="bugs" \
    -v $(pwd)/data/mysql:/var/lib/mysql \
    --name mysql tutum/mysql
# manually create db named bugs;
mysql --host=0.0.0.0 --port=3307 -pbugs -uadmin 
> create database bugs;
> \q
# 

# build this instance (if neeeded)
docker build -rm -t romanlv/docker-testopia .


# run it (rm part is optional, needed if rebuilding)
docker rm -f testopia && \
docker run -d -t \
    --name testopia \
    --privileged \
    --link mysql:db \
    -v $(pwd):/config \
    -v $(pwd)/data/app:/home/bugzilla/www/data \
    --hostname testopia \
    --publish 3000:80 \
    romanlv/docker-testopia


# only first time - init database, set permissions and restart
docker exec testopia sh db_config.sh && docker restart testopia 


