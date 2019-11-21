FROM alpine:latest

ENV ENV /root/.profile
ADD . /root/lbdk
RUN /root/lbdk/lbdk.sh

CMD sh
