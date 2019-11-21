# xps2/subversion-edge

This is a docker image of the Collabnet Subversion Edge Server

forked from mamohr/subversion-edge

## Fork modifications (ubi7)

* Changed to ubi7-minimal image.
* Changed from Oracle JRE to OpenJDK.
* If you are migrating from mamohr/subversion-edge, you need to change JAVA_HOME to '/usr/lib/jvm/jre'. Please edit '/srv/svn-data/conf/csvn.conf'.

## Usage

The image is exposing the data dir of csvn as a volume under `/opt/csvn/data`.
If you provide an empty host folder as volume the init scripts will take care of copying a basic configuration to the volume.
The container exposes the following ports:

 * 3343 - HTTP CSVN Admin Sites
 * 4434 - HTTPS CSVN Admin Sites (If SSL is enabled)
 * 80 - Apache Http SVN
 * 443 - Apache Https SVN (If SSL is enabled)

The simplest way to start a subversion edge server is

    docker run -d xps2/subversion-edge:ubi7

This will run the server. It will only be reachable from the docker host by using the container ip address

Exposing the ports from the host:
    
    docker run -d -p 3343:3343 -p 4434:4434 -p 80:80 -p 443:443 \
        --name svn-server xps2/subversion-edge:ubi7

This will make the admin interface reachable under [http://docker-host:3343/csvn](http://docker-host:3343/csvn).

If you want to provide a host path for the data use command like this:

    docker run -d -p 3343:3343 -p 4434:4434 -p 80:80 -p 443:443 \
        -v /srv/svn-data:/opt/csvn/data --name svn-server xps2/subversion-edge:ubi7
    

For information to further configuration please consult the documentation at [CollabNet](http://collab.net/products/subversion).
