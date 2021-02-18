# Ubuntu 20.04 LTS in Docker (v1.3)

1 How to install:
  * With git:
    * git clone https://github.com/acaldero/u20-docker.git
    * cd u20-docker
  * With wget:
    * wget https://github.com/acaldero/u20-docker/archive/main.zip
    * unzip main.zip
    * cd u20-docker-main

2 How to use it:
  * First time + "each time u20-dockerfile is updated", please execute:
    * ./u20.sh build

  * For a typical work session with **3** containers, please execute:
    *  ./u20.sh start **3**
    *  ./u20.sh bash **2**
    *  <do some work inside container **2** at /work directory>
    *  exit
    *  ./u20.sh stop

  * Available options for debugging:
    *  ./u20.sh status
    *  ./u20.sh network
    *  ./u20.sh cleanup

3 Beware of:
  * Work inside /work and make backup "frequently":
    * Any modification outside /work will be discarded on container stopping.
    * Please make a backup of your work "frequently".
  * You need to install Docker first:
    * On Linux Ubuntu: (Thanks to Erik de la Cruz Trujillo) "install using the repository" from https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
    * On Windows 10 version 20H2: https://docs.docker.com/docker-for-windows/wsl/

