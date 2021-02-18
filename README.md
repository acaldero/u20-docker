# Ubuntu 20.04 LTS in Docker (v1.3)

## Prerequisites

 * [Docker + Docker-compose](./DOCKER.md) 

## Getting u20-docker

```
git clone https://github.com/acaldero/u20-docker.git
cd u20-docker
./u20.sh build
```

## Using u20-docker

<html>
 <table>
  <tr>
  <th>Summary</th>
  <th>Example of work session</th>
  </tr>
  <tr>
  <td>
</html>

  * First time + "each time u20-dockerfile is updated", please execute:
    * ./u20.sh build

  * For a work session with **3** containers, please execute:
    *  ./u20.sh start **3**
    *  ./u20.sh bash **2**
    *  <do some work inside container **2** at /work directory>
    *  exit
    *  ./u20.sh stop

  * Available options for debugging:
    *  ./u20.sh status
    *  ./u20.sh network

<html>
  </td>
  <td>
</html>

  * To start:
    * To start a work session with **2** containers, please execute:
      *  ./u20.sh start **2**
    * To check the containers are running please use:
      *  ./u20.sh status
    * To get the containers internal IP address please use:
      *  ./u20.sh network

  * To work with some container:
    * To get into container **1** out of 2 please execute:
      *  ./u20.sh bash **1**
    * <some work inside container **1** at /work directory>
    * To exit from container **1** please use:
      *  exit

  * To stop:
    * To stop the work session please use:
      *  ./u20.sh stop

<html>
  </td>
  </tr>
 </table>
</html>



**Please beware of**:
  * Any modification outside /work will be discarded on container stopping.
  * Please make a backup of your work "frequently".
