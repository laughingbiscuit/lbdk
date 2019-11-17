FROM alpine:latest

ADD . /tmp
RUN /tmp/lbdk.sh

CMD sh
