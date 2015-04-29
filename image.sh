#!/usr/bin/env bash

set -x
for i in base api engine ; do
cd $i
SHA=$(docker build . | grep 'Successfully built' | cut -d ' ' -f 3)
docker tag -f $SHA michchap/heat$i:latest
docker push -f michchap/heat$i:latest
cd ..
done

