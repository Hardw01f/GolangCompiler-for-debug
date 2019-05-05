FROM centos:latest

USER root

#WORKDIR /go

WORKDIR /root/

RUN yum update -y && yum install -y epel-release \
	vim \
	gcc \
	wget \
	git \
	gdb \
	zsh

RUN mkdir /root/FirstCompiler && mkdir /root/goEnv

RUN wget https://dl.google.com/go/go1.4.linux-amd64.tar.gz && tar -xzf go1.4.linux-amd64.tar.gz && mv go go1.4

RUN git clone https://go.googlesource.com/go /root/goEnv/go && cd /root/goEnv/go && git checkout go1.9 

#ENV GOROOT /root/goEnv/go

WORKDIR /root/goEnv/go/src

RUN sh /root/goEnv/go/src/make.bash

#ENV GOROOT $HOME/go

WORKDIR /root/goEnv/go/src/cmd/go

RUN /root/goEnv/go/bin/go build -gcflags '-N -l' -o /root/goEnv/go/bin/go 


#RUN wget https://dl.google.com/go/go1.12.3.linux-amd64.tar.gz && tar vzfx go1.12.3.linux-amd64.tar.gz && mv /go/go /usr/bin/ && mkdir -p /DevSpace

ENV PATH $PATH:/usr/bin/go/bin
#ENV GOPATH /go
ENV PATH $PATH:/go/bin
ENV TZ Asia/Tokyo


