FROM alpine:latest

ADD . /root
RUN /root/lbdk.sh

CMD sh
