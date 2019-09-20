FROM alpine:latest

WORKDIR /root
COPY . /root/lbdk
RUN apk add bash
RUN bash /root/lbdk/lbdk.sh

CMD bash
