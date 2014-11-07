#### docker-bugzilla

! IN PROGRESS, DOES NOT WORK YET 

Configure a running Bugzilla + Testopia system using Docker

##### Features:

* Running Ubuntu 14.04
* Preconfigured with initial data and test product
* Code resides in `/home/bugzilla/devel/htdocs/bugzilla` and can be updated using standard git commands

##### How to build

If you need to build the base image for yourself,  just change to the directory containing the checked out
files and run the below command:

```bash
$ docker build -rm -t <my_name>/docker-bugzilla .
```

The `-rm` switch removes any interim containers automatically while the image is being created.

##### How to start

```bash
$ docker run -d -t \
    --name bugzilla \
    --publish 8080:80 \
    romanlv/docker-bugzilla
```

This will pull down the docker image from the Docker Registry and start it for you

To stop and remove the container, you can do:

```bash
$ docker stop bugzilla
$ docker rm bugzilla
```

You can point your browser to `http://localhost:8080/bugzilla` to see the the Bugzilla home page.
You can ssh into the container using `ssh bugzilla@localhost -p2222`. The password is `bugzilla`.
The above command that starts the container is also in the `bugzilla_start.sh` file. Once the image
is cache locally, starting the container should happen very quickly. You can run multiple containers
but you will need to give each one a different name/hostname as well as non-conflicting ports numbers
for ssh and httpd.




