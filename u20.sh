#!/bin/bash
#set -x

#
#  Copyright 2019-2023 Saul Alonso Monsalve, Felix Garcia Carballeira, Jose Rivadeneira Lopez-Bravo, Alejandro Calderon Mateos,
#
#  This file is part of U20 proyect.
#
#  U20 is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  U20 is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public License
#  along with U20.  If not, see <http://www.gnu.org/licenses/>.
#




#
# Usage
#

if [ $# -eq 0 ]; then
	$0 help
	exit
fi


#
# check docker
#

docker -v >& /dev/null
status=$?
if [ $status -ne 0 ]; then
     echo ": docker is not found in this computer."
     echo ": * Did you install docker?."
     echo ":   Please visit https://docs.docker.com/get-docker/"
     echo ""
     exit
fi


#
# for each argument, try to execute it
#

 DOCKER_PREFIX_NAME=docker
#DOCKER_PREFIX_NAME=docker-node
#DOCKER_PREFIX_NAME=docker_node
#DOCKER_PREFIX_NAME=docker.node.
#DOCKER_PREFIX_NAME=mfs-node
#DOCKER_PREFIX_NAME=$(basename $(pwd))"-node"
#DOCKER_PREFIX_NAME=$(basename $(pwd))"_node"

while (( "$#" ))
do
	arg_i=$1
	case $arg_i in
	     build)
		# Check params
		if [ ! -f u20-dockerfile ]; then
		    echo ": The u20-dockerfile file is not found."
		    echo ": * Did you execute git clone https://github.com/acaldero/u20-docker.git?."
		    echo ""
		    exit
		fi

		# Build image
		echo "Building initial image..."
		docker image build -t u20 -f u20-dockerfile .

		# Make export directory
		mkdir -p export
	     ;;

	     start)
		shift

		# Start container cluster (single node)
		echo "Building containers..."
		docker-compose -f u20-dockercompose.yml up -d --scale node=$1
		if [ $? -gt 0 ]; then
		    echo ": The docker-compose command failed to spin up containers."
		    echo ": * Did you execute git clone https://github.com/acaldero/u20-docker.git?."
		    echo ""
		    exit
		fi

		# Container cluster (single node) files...
		CONTAINER_ID_LIST=$(docker ps -f name=node -q)
		docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_ID_LIST > machines
	     ;;

	     bash)
                shift

		# Check params
                CO_ID=$1
		CO_NC=$(docker ps -f name=$DOCKER_PREFIX_NAME -q | wc -l)
                if [ $CO_ID -lt 1 ]; then
			echo "ERROR: Container ID $CO_ID out of range (1...$CO_NC)"
                	shift
                        continue
                fi
                if [ $CO_ID -gt $CO_NC ]; then
			echo "ERROR: Container ID $CO_ID out of range (1...$CO_NC)"
                	shift
                        continue
                fi

		# Bash on container...
		echo "Executing /bin/bash on container $CO_ID..."
		CO_NAME=$(docker ps -f name=$DOCKER_PREFIX_NAME -q | head -$CO_ID | tail -1)
		docker exec -it $CO_NAME /bin/bash
	     ;;

	     stop)
		# Stopping containers
		echo "Stopping containers..."
		docker-compose -f u20-dockercompose.yml down
		if [ $? -gt 0 ]; then
		    echo ": The docker-compose command failed to stop containers."
		    echo ": * Did you execute git clone https://github.com/acaldero/u20-docker.git?."
		    echo ""
		    exit
		fi

		# Remove container cluster (single node) files...
		rm -fr machines
	     ;;

	     status)
		echo "Show status of current containers..."
		docker ps
	     ;;

	     network)
		echo "Show status of current IPs..."
		CONTAINER_ID_LIST=$(docker ps -f name=$DOCKER_PREFIX_NAME -q)
		docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_ID_LIST
	     ;;

	     cleanup)
		# Removing everything (warning) 
		echo "Removing containers and images..."
                docker rm      -f $(docker ps     -a -q)
                docker rmi     -f $(docker images -a -q)
                docker volume rm  $(docker volume ls -q)
                docker network rm $(docker network ls|tail -n+2|awk '{if($2 !~ /bridge|none|host/){ print $1 }}')
	     ;;

	     mpirun)
		# Get parameters
		shift
		NP=$1
		shift
		A=$@
		shift
		shift

		CNAME=$(docker ps -f name=node -q | head -1)

		# Check params
		if [ "x$CNAME" == "x" ]; then
		    echo ": There is not a running u20 container."
		    exit
		fi

		if [ ! -f machines ]; then
		    echo ": The machines file was not found."
		    exit
		fi

		# U20
		docker container exec -it $CNAME     \
		       mpirun -np $NP -machinefile machines \
			      --oversubscribe \
			      -bind-to none -map-by slot -verbose --allow-run-as-root \
			       -x LD_LIBRARY_PATH -x PATH \
			       -x NCCL_SOCKET_IFNAME=^lo,docker0 \
			       -mca pml ob1 -mca btl ^openib \
			       -mca btl_tcp_if_exclude lo,docker0,eth1 \
			      $A
	     ;;

	     help)
		echo ""
		echo "  Ubuntu 20.04 on docker (v2.0) "
		echo " -------------------------------"
		echo ""
		echo "  Usage: $0 <action> [<options>]"
		echo ""
		echo "  : First time, and each time u20-dockerfile is update, please execute:"
		echo "        $0 build"
		echo ""
		echo "  : A typical work session has 3 steps:"
		echo "    1) First, please start the work session with:"
		echo "        $0 start <number of containers>"
		echo "        $0 status"
		echo "        $0 network"
		echo "    2) Then you can perform different actions... (see Actions)"
		echo "    3) Lastly, please stop the work session with:"
		echo "        $0 stop"
		echo ""
		echo "  : Actions:"
		echo "    : In order to work with a single container, please execute:"
		echo "        $0 bash <container id, from 1 to number_of_containers>"
		echo "        <some work within container>"
		echo "        exit"
		echo "    : In order to work with all containers, please execute:"
	        echo "        $0 mpirun 2 \"<command>\""
		echo ""
		echo "  : Available option to uninstall u20-docker (remove images + containers):"
		echo "        $0 cleanup"
		echo ""
	     ;;

	     *)
		echo ""
		echo "Unknow command: $1"
                $0 help
	     ;;
	esac

	shift
done

