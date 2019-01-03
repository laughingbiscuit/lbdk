FROM debian:stretch

WORKDIR /root
COPY . /root/lbdk
RUN /root/lbdk/lbdk.sh

CMD bash
