# Alpine based rsync service


## Introduction

Simple rsync service built for many architectures 

rsync runs on tcp/8730 and logs are send to stdout.

## Usage

Data should be mounted to or under /export

The /etc/rsyncd.conf configuration file may be overwritten as needed

## Usage examples

Run basic service on tcp/830 (the default rsync service port)
``` script
docker run -p 873:8730 -v /mydata/:/export/ -it rugarci/rsync-server
```

Use a custom rsyncd configuration and multiple mounts
``` script
docker run -p 873:8730 \
    -v /mydata/:/export/data/ \
    -v /my-www/:/export/www/ \
    -v $(pwd)/rsyncd.conf:/etc/rsyncd.conf \
    -it rugarci/rsync-server
```
