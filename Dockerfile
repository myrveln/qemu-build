FROM alpine:latest
RUN apk --update upgrade \
 && apk add curl
RUN arch
