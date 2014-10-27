### Learning Docker http://docker.io/ by creating a Postgres container.

### To build:

	Spostarsi nella directory e lanciare il comando
    sudo docker build -t tornabene/docker-postgres .
  
### To run:

    sudo docker pull tornabene/docker-postgres
    sudo docker run -d --name postgres.ntipa.it -p 5432:5432 -p 9922:22  tornabene/docker-postgres
    
### To persist your data:

Here we persistently save our data to the host machine's ``/opt/ntipa/postgresql_data`` directory.

    sudo mkdir -p /opt/ntipa/postgresql_data
    sudo docker run --name postgres.ntipa.it -p 5432:5432 -p 9922:22 -v  /opt/ntipa/postgresql_data:/var/lib/postgresql   tornabene/docker-postgres 
