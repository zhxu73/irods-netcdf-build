#!/bin/bash

readonly OS="$1"

mkdir --parents /packages/"$OS"

for pkg in api microservices icommands
do
  /src/"$pkg"/packaging/build.sh -r
  cp --update /src/"$pkg"/build/* /packages/"$OS"
done

readonly LibDir=/usr/lib

case "$OS"
in
  centos-6)
    pkgId=centos6
    ;;
  centos-7)
    pkgId=centos7
    ;;
  ubuntu-12)
    pkgId=ubuntu12
    ;;
  ubuntu-14)
    pkgId=ubuntu14
    ;;    
esac

# Gather irods-runtime contents
mkdir --parents /src/tar/irods/externals
cp --no-dereference --update "$LibDir"/libirods*.so* /src/tar
cp --no-dereference --update "$LibDir"/irods/externals/*.so* /src/tar/irods/externals
tar --create --gzip --directory /src/tar --file /packages/"$OS"/irods-runtime-4.1.10-"$pkgId".tgz .
