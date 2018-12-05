FROM debian:stretch

COPY . /home/devkit
RUN /home/devkit/lbdk.sh

CMD bash
