FROM centos:latest

USER root

WORKDIR /root/

# Install gcc and etc.
RUN yum update -y && yum install -y epel-release \
	vim \
	gcc \
	wget \
	git \
	gdb \
	make \
	zsh

# Firstcompiler Dir for go1.4, goEnv Dir for debuging of golang:latest, WorkDir is used for place of sample source 
RUN mkdir /root/FirstCompiler && mkdir /root/goEnv && mkdir /root/WorkDir

COPY ./Greeting.go /root/WorkDir/

# Get go1.4 for compile golang:latest
RUN wget https://dl.google.com/go/go1.4.linux-amd64.tar.gz && tar -xzf go1.4.linux-amd64.tar.gz && mv go go1.4

# Get golang:latest
RUN git clone https://go.googlesource.com/go /root/goEnv/go && cd /root/goEnv/go && git checkout go1.9 

WORKDIR /root/goEnv/go/src

# Install golang:latest used go1.4
RUN sh /root/goEnv/go/src/make.bash

WORKDIR /root/goEnv/go/src/cmd/go

# Self rebuild golang:latest with debug option 
RUN /root/goEnv/go/bin/go build -gcflags '-N -l' -o /root/goEnv/go/bin/go 

# Set PATHs
ENV PATH $PATH:/root/goEnv/go/bin
ENV GOPATH /root/goEnv/go
ENV PATH $PATH:/go/bin
ENV TZ Asia/Tokyo

# Get delve
RUN git clone https://github.com/go-delve/delve.git $GOPATH/src/github.com/go-delve/delve

WORKDIR /root/goEnv/go/src/github.com/go-delve/delve

# Install delve
RUN make install

WORKDIR /root
