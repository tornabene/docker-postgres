### Learning Docker http://docker.io/ by creating a Postgres container.

### To build:

	Spostarsi nella directory e lanciare il comando
    sudo docker build -t tornabene/docker-postgres .
  
### To run:

    sudo docker pull tornabene/docker-postgres
    sudo docker run -d --name postgres.ntipa.it -p 5432:5432 -p 9922:22  tornabene/docker-postgres
    
### To persist your data:

Here we persistently save our data to the host machine's ``/opt/ntipa/postgres`` directory.

    sudo mkdir -p /opt/ntipa/postgres  /opt/ntipa/postgres/etc /opt/ntipa/postgres/log  /opt/ntipa/postgres/data /opt/ntipa/postgres
    
    sudo docker run --name postgres.ntipa.it -p 5432:5432 -p 9922:22 -v /opt/ntipa/postgres/etc:/etc/postgresql    -v /opt/ntipa/postgres/log:/var/log/postgresql     -v /opt/ntipa/postgres/data:/var/lib/postgresq   tornabene/docker-postgres 
    
    
     