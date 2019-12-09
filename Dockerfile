#��һ�׶Σ�����һ��ubuntu�����������氲װgcc���빤�ߣ�������Դ�����
#�Բ�ͬ�ļܹ���Ҫ��װ��Ӧ��gcc��������������ʾx86ƽ̨
FROM ubuntu@sha256:3e83eca7870ee14a03b8026660e71ba761e6919b6982fb920d10254688a363d4 as builder
WORKDIR /work
RUN apt-get update &&\
        apt-get install -y wget unzip gcc
RUN     wget https://github.com/lshjn/docker-335x-test/archive/master.zip &&\
        unzip master.zip &&\
        cd docker-335x-test-master &&\
        gcc -o test test.c
#�ڶ��׶Σ��½�����busybox�ľ��������������������Ҫ�ı�Ҫ����
FROM busybox@sha256:916020ef62f70c4a9f4cccfab67c0bd38ef96ff245ab394c9b9c8f4f26626420
WORKDIR /work_test
COPY --from=builder /work/docker-335x-test-master/test .
CMD ["./test"]
