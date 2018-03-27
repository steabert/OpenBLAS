FROM alpine:latest AS build
RUN apk add --no-cache linux-headers
RUN apk add --no-cache libc-dev
RUN apk add --no-cache gfortran
RUN apk add --no-cache make
RUN apk add --no-cache perl
ADD . OpenBLAS
WORKDIR OpenBLAS
RUN make NO_LAPACK=0 INTERFACE64=1 BINARY=64 DYNAMIC_ARCH=1
RUN make install

FROM scratch
COPY --from=build /opt/OpenBLAS /opt/OpenBLAS
