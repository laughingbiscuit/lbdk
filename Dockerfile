FROM alpine:3

ADD . /root
RUN /root/lbdk.sh

CMD sh
