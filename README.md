### Learning Docker http://docker.io/ by creating a Postgres container.

### To build:

	Spostarsi nella directory e lanciare il comando
    sudo docker build tornabene/docker-postgres .
  
### To run:

    sudo docker pull tornabene/docker-postgres
    sudo docker run -d --name postgres.ntipa.it -p 5672:5672 -p 15672:15672 -p 9922:22  tornabene/docker-postgres
    
### To persist your data:

Here we persistently save our data to the host machine's ``/opt/ntipa/postgres`` directory.

    mkdir -p /opt/ntipa/postgres
    chmod 777 /opt/ntipa/postgres
    sudo docker run -d --name postgres.ntipa.it -p 5672:5672 -p 15672:15672 -p 9922:22  tornabene/docker-postgres -v /opt/ntipa/postgres:/var/lib/postgres/ntipa tornabene/docker-postgres