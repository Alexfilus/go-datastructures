FROM apline/git as base
FROM golang:1.16-alpine3.13 AS build-go

ARG GIT_SSH_KEY
ARG KNOWN_HOSTS_CONTENT
WORKDIR /go/src/github.com/Workiva/go-datastructures/
ADD . /go/src/github.com/Workiva/go-datastructures/

ARG GOPATH=/go/
ENV PATH $GOPATH/bin:$PATH
RUN git config --global url.git@github.com:.insteadOf https://github.com
RUN echo "Starting the script section" && \
    go mode vendor && \
    echo "script section completed"

ARG BUILD_ARTIFACTS_DEPENDENCIES=/go/src/github.com/Workiva/go-datastructures/go.mod

FROM scratch
