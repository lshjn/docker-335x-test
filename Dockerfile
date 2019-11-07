#第一阶段，创建一个ubuntu的容器，里面安装gcc编译工具，并下载源码编译
#对不同的架构需要安装相应的gcc工具链，这里演示x86平台
FROM ubuntu@sha256:3e83eca7870ee14a03b8026660e71ba761e6919b6982fb920d10254688a363d4 as builder
WORKDIR /work
RUN apt-get update &&\
        apt-get install -y wget unzip gcc
RUN     wget https://github.com/lshjn/docker-335x-test/archive/master.zip &&\
        unzip master.zip &&\
        cd docker-335x-test-master &&\
        gcc -o test test.c
#第二阶段，新建基于busybox的镜像，里面包括程序运行需要的必要环境
FROM busybox@sha256:fe81fcea1790604cb78c3191507809fcaea34a7d81afeb71526ad8b138f81268
WORKDIR /work_test
COPY --from=builder /work/docker-335x-test-master/test .
CMD ["./test]
