#### Dockerizing Magento 2 with Docker-Compose

In this project, we are using:

> Operating system: Ubuntu 16.04

> Web Server: Apache2

> Database Server: Mysql-server-5.7

> PHP version: PHP-7.1

> Magento version: Magento-CE-2.3.4

To begin with, please install docker and docker-compose. 

Then follow the following steps:

1). Download Magento-CE-2.3.4 and unzip the files and diretories to magento2 folder 


2) Set mysql root credentials and name of the database to be created . Go to ~/docker-compose.yml and change mysql root password in database_server in:

>  MYSQL_DATABASE: magento2

>  MYSQL_USER: qbuser

>  MYSQL_USER: qbpass

3) Set up custom port to set up up magento localhost url, Currently 8085 is used so the local site is accesed as http://127.0.0.1:8085/
>   - "8005:80"

4). Build the docker image.

> docker-compose build

5). Check the built image as:

> docker images

6). Run the containers from built image as:

> docker-compose up -d

7). Check the running docker containers by command:

> docker ps

8) You can check the server requirement are ok for magento installation in this url : http://127.0.0.1:8085/reqCheck.php

9). Set up Magento bu using http://127.0.0.1:8085/, provide the same DB details added in docker-compose.yml

10). Complete the setup and site is visible in http://127.0.0.1:8085/ url.

