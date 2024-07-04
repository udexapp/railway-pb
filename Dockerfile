FROM alpine:latest

ARG PB_VERSION=0.22.15

RUN apk add --no-cache \
    unzip \
    ca-certificates

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# Uncomment to Copy the Local pb_hooks dir into the image
COPY ./pb_hooks /pb/pb_hooks

# Uncomment to Copy the Local pb_public dir into the image
COPY ./pb_public /pb/pb_public

EXPOSE 8080

# start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
