# Ubuntu 20.04 LTS in Docker (v1.2)

1 How to install:
  * git clone https://github.com/acaldero/u20-docker.git
  * cd u20-docker

2 How to use it:
  * First time (and each time u20-dockerfile is update) please execute:
    * ./u20.sh build

  * For a typical work session with 3 containers, please execute:
    *  ./u20.sh start 3
    *  ./u20.sh bash 2
    *  <do some work inside container 2 at /work directory>
    *  exit
    *  ./u20.sh stop

  * Available options for debugging:
    *  ./u20.sh status
    *  ./u20.sh network
    *  ./u20.sh cleanup

3 Beware of:
  * Any modification outside /work will be discarded on container stopping.
  * Please make a backup of your work "frequently".
