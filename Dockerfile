FROM alpine:3.12

ADD . /root
RUN /root/lbdk.sh

CMD tmux
