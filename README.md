# Ubuntu 20.04 LTS in Docker (v1.3)

## Prerequisites

 * [Docker + Docker-compose](./DOCKER.md) 

## Get u20-docker

<html>
 <table>
  <tr>
  <th>With wget</th>
  <th>With git</th>
  </tr>
  <tr>
  <td>
</html>

  * wget https://github.com/acaldero/u20-docker/archive/main.zip
  * unzip main.zip
  * cd u20-docker-main
  * ./u20.sh build

<html>
  </td>
  <td>
</html>

  * git clone https://github.com/acaldero/u20-docker.git
  * 
  * cd u20-docker
  * ./u20.sh build

<html>
  </td>
  </tr>
 </table>
</html>


## How to use it


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


**Please beware of**:
  * Any modification outside /work will be discarded on container stopping.
  * Please make a backup of your work "frequently".

