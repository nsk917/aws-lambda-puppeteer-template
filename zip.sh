#!/bin/bash -x

DIR=$(cd $(dirname $0); pwd)
mkdir -p $DIR/nodejs
rm -rf $DIR/lambda-layer.zip $DIR/nodejs/node_modules
cp $DIR/package*.json $DIR/nodejs/

npm isntall --production --prefix nodejs
rm -rf $DIR/nodejs/package*.json

zip -9 -r lambda-layer.zip nodejs