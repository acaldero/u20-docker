ARG UBUNTU_VERSION=20.04
FROM ubuntu:${UBUNTU_VERSION} AS base

ENV DEBIAN_FRONTEND=noninteractive 

# Install initial software
RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        aptitude apt-utils \
        zlib1g-dev ca-certificates pkg-config \
        software-properties-common gpg-agent \
        curl libcurl3-dev \
        wget rsync \
        sudo lshw \
        vim \
        \
        build-essential \
        autoconf cmake g++ git \
        gdb valgrind strace \
        nasm \
        man-db doxygen \
        htop lsof \
        \
        inetutils-ping \
        netcat \
        nmap net-tools hping3 \
        iftop nload \
        \
        kmod \
        nfs-common nfs-kernel-server \
        \
        libtool \
	rpcbind \
	openjdk-8-jdk \
	libjson-c-dev \
        jq \
        \
        zip unzip unrar p7zip-full p7zip-rar \
        \
        libmpich-dev libmpich12 mpich mpich-doc netpipe-mpich2 \
        \
        yamllint \
        ubuntu-restricted-extras \
        imagemagick \
        && \
    apt-get clean

# tzdata: Configure region
RUN echo "Europe/Madrid" > /etc/timezone
#RUN dpkg-reconfigure -f noninteractive tzdata


# OpenSSH: Install
RUN apt-get install -y --no-install-recommends openssh-client openssh-server
RUN mkdir -p /var/run/sshd

# OpenSSH: Allow Root login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/#PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
# OpenSSH: Allow to talk to containers without asking for confirmation
RUN cat /etc/ssh/ssh_config | grep -v StrictHostKeyChecking > /etc/ssh/ssh_config.new && \
    echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config.new && \
    mv /etc/ssh/ssh_config.new /etc/ssh/ssh_config
# OpenSSH: keygen
RUN ssh-keygen -q -t rsa -N "" -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys


# Initial env
RUN echo 'root:ssdd' | chpasswd

RUN mkdir -p /work
WORKDIR "/work"

# container start-up
RUN mkdir -p /srv
COPY u20-dockerstart.sh /srv

EXPOSE 22
CMD ["/srv/u20-dockerstart.sh"]

