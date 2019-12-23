FROM alpine:latest

ENV HOME /root
ENV ENV /root/.profile
ADD . /root/lbdk
RUN /root/lbdk/lbdk.sh

CMD sh
