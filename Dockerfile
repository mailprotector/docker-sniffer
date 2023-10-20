FROM debian:bookworm-slim
LABEL maintainer="devops@mailprotector.net"

# Debian Base to use
ENV DEBIAN_VERSION bookworm

RUN echo "deb https://http.debian.org/debian/ $DEBIAN_VERSION main contrib non-free" > /etc/apt/sources.list && \
    echo "deb https://http.debian.org/debian/ $DEBIAN_VERSION-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb https://security.debian.org/ $DEBIAN_VERSION/updates main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y wget xinetd procps net-tools
RUN cd /tmp && \
    wget --quiet --no-check-certificate https://www.armresearch.com/message-sniffer/download/packages/snf-server_ubuntu-9-10x64_deb/snf-server_3.2.0-1_amd64.deb && \
    apt-get install /tmp/snf-server_3.2.0-1_amd64.deb -y

COPY config/* /etc/snf-server/
COPY bootstrap.sh /

RUN ["chmod", "-R", "u+x", "/bootstrap.sh"]
RUN ["touch", "/usr/share/snf-server/UpdateReady.txt"]

CMD ["/bootstrap.sh"]
EXPOSE 9001