# Ubuntu 20.04 LTS in Docker (v1.3)

<html>
 <table>
  <tr>
  <th>(1) How to install</th>
  <th>(2) How to use it</th>
  </tr>
  <tr>
  <td width="55%">
</html>

* IF you need to install Docker THEN:
  * On Linux Ubuntu:
    * (Thanks to Erik de la Cruz Trujillo) "install using the repository" from https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
  * On Windows 10 version 20H2:
    * https://docs.docker.com/docker-for-windows/wsl/

* To get u20-docker:
  * With git:
    * git clone https://github.com/acaldero/u20-docker.git
    * cd u20-docker
  * With wget:
    * wget https://github.com/acaldero/u20-docker/archive/main.zip
    * unzip main.zip
    * cd u20-docker-main

<html>
  </td>
  <td>
</html>

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

<html>
  </td>
  </tr>
 </table>
</html>

**Beware of**:
  * Any modification outside /work will be discarded on container stopping.
  * Please make a backup of your work "frequently".

