# nao#

nao# aims to provide a ROS installation which contains all relevant tools to simulate a NAO inside Unity using [ROS#](https://github.com/siemens/ros-sharp).
Everything is packaged inside a docker container so that it is easy to setup.


## Setup and run

Install docker (and, if not included, docker-compose), Unity and setup ROS# as explained in their [wiki](https://github.com/siemens/ros-sharp/wiki).
A common problem is forgetting to set the scripting from 3.5 to 4.x (Edit -> Project settings -> Player), make sure you do that!
We are assuming version 1.3, but you can adjust the .rosinstall to support other versions if needed.
Build the docker image and run docker-compose up (the first docker-compose up builds the image automatically):

```bash
docker build . -t naosharp
docker-compose up
```


## Importing the Nao

Use the RosBridgeClient to import the Nao, not that the socket address must be ws://127.0.0.1:9090 instead of the default value.

