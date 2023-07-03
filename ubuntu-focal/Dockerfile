FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV USER=shakugan \
    PASSWORD=AliAly032230 \
    UID=1000 \
    GID=1000

RUN groupadd -g $GID $USER
RUN useradd --create-home --no-log-init -u $UID -g $GID $USER
RUN usermod -aG sudo $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN chsh -s /bin/bash $USER


RUN apt-get update && apt-get full-upgrade -y && apt-get -y dist-upgrade && apt-get -y autoremove
RUN apt-get -y install locales wget openssh-server sudo curl vim bash wget gnupg dialog apt-utils unzip xz-utils build-essential net-tools default-jre nano
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
RUN wget https://file.cnxiaobai.com/Linux/Java/Oracle%20JDK/JDK%2018/jdk-18_linux-x64_bin.deb
RUN wget https://github.com/coder/code-server/releases/download/v4.14.1/code-server_4.14.1_amd64.deb
RUN wget https://github.com/azimjohn/jprq/releases/download/2.1/jprq-linux-amd64 && chmod +x jprq-linux-amd64 && mv jprq-linux-amd64 /usr/local/bin/jprq
RUN apt-get -y install ./*.deb && rm -rf *.deb


ENTRYPOINT /bin/bash
