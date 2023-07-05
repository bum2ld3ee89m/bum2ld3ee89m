FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive

# INSTALL
RUN apt-get update && apt-get full-upgrade -y && apt-get -y dist-upgrade && apt-get -y autoremove
RUN apt-get -y install locales wget openssh-server sudo curl vim bash wget gnupg dialog apt-utils unzip xz-utils build-essential net-tools default-jre nano 
#RUN ubuntu-mate-desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
RUN wget https://file.cnxiaobai.com/Linux/Java/Oracle%20JDK/JDK%2018/jdk-18_linux-x64_bin.deb
RUN wget https://github.com/coder/code-server/releases/download/v4.14.1/code-server_4.14.1_amd64.deb
RUN apt-get -y install ./*.deb && rm -rf *.deb

# ADMIN
RUN useradd -m -s /bin/bash shakugan
RUN usermod -append --groups sudo shakugan
RUN echo "shakugan:AliAly032230" | chpasswd
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# JPRQ
RUN wget https://github.com/azimjohn/jprq/releases/download/2.1/jprq-linux-amd64 && chmod +x jprq-linux-amd64 && mv jprq-linux-amd64 /usr/local/bin/jprq
RUN jprq auth bpLb89BDIcVfQPib71plo38bWtKvC84FRgzl
RUN jprq tcp 22 >> /home/shakugan/jprq.log &

# NGROK
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
RUN tar xvzf ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin
RUN ngrok config add-authtoken 2RmVasdc3ML5XNCkBwE9ebdvXvv_4QPqbRcHZbzaiVoWriF1D

# SSH
RUN mkdir -p /var/run/sshd
RUN sed -i 's\#PermitRootLogin prohibit-password\PermitRootLogin yes\ ' /etc/ssh/sshd_config
RUN sed -i 's\#PubkeyAuthentication yes\PubkeyAuthentication yes\ ' /etc/ssh/sshd_config

EXPOSE 22 10000
ENTRYPOINT service ssh start && ngrok tcp 22
