# Ubuntu 20.04 LTS in Docker (v1.2)

Usage: ./u20.sh <build | start | bash | stop | status | network>

  * First time (and each time u20-dockerfile is update) please execute:
    * ./u20.sh build

  * For a typical work session with 3 containers, please execute:
    *  ./u20.sh start 3
    *  ./u20.sh bash 2
    *  <do some work inside container 2...>
    *  exit
    *  ./u20.sh stop

  * Available options for debugging:
    *  ./u20.sh status
    *  ./u20.sh network
    *  ./u20.sh cleanup

