#### docker-bugzilla

Configure a running Bugzilla + Testopia system using Docker

##### Features:

* Running Ubuntu 14.04
* Nginx instead of apache (only one worker at the moment though)
* configuration for bugzilla/testopia provided in volume (as attached data), so no need to rebuild image after changing db connection parameters
* mysql 


##### How to build

If you need to build the base image for yourself,  just change to the directory containing the checked out
files and run the below command:

```bash
$ docker build -rm -t <my_name>/docker-testopia .
```

The `-rm` switch removes any interim containers automatically while the image is being created.

##### How to start

###### prepare db (if you want to use docker container for mysql server)

```
docker run -d -p 3307:3306 -e MYSQL_PASS="bugs" --name mysql tutum/mysql
```
manually create db named bugs;

> mysql --host=0.0.0.0 --port=3307 -pbugs -uadmin 
```sql
create database bugs;
\q
```

##### run container

```bash
$ docker run -d -t \
    --name testopia \
    --link mysql:db \
    -v $(pwd):/config \
    --hostname testopia \
    --publish 3000:80 \
    romanlv/docker-testopia
```


before using first time - init database, set permissions and restart
>  make sure checksetup_answers.txt exists in the current folder 
```bash
# for some reason runs endless loop when running first time, just Ctrl+C and run again
$ docker exec testopia sh db_config.sh && docker restart testopia 
```


This will pull down the docker image from the Docker Registry and start it for you

To stop and remove the container, you can do:

```bash
$ docker stop testopia
$ docker rm testopia
```

You can point your browser to `http://localhost:3000` to see the the Bugzilla home page.




