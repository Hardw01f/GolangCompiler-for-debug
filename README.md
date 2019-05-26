# GolangCompiler-for-debug
Environment for debug of Golang compiler

## Build and Run

```
#build 

$ docker run -t go_debug:latest .

#run and into container

$ docker run -it --cap-add=SYS_PTRACE --security-opt="seccomp=unconfined" go_debug:latest /bin/zsh
```

### Plot of install Golang

Needs
- gcc
- go1.4
- golang:latest


- 1.gcc use build go1.4
- 2.go1.4 use build golang:latest

### Into Container

```
# TEST

$ cd WorkDir
$ go run Greeting.go

OUTPUT : I am Ironman

```

### Debug

- GDB

```
$ cd WorkDir 
$ gdb /root/goEnv/go/bin/go

(gdb) b main.main
(gdb) r build /root/WorkDir/Greeting.go

```

- delve

```
$ cd WorkDir
$ go build Greeting.go
$ dlv exec ./Greeting --check-go-version=false
```

## Warning

This Dockerfile has many layer, so image size is large 


