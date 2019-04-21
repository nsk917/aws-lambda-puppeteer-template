#!/bin/bash -x

DIR=$(cd $(dirname $0); pwd)
cd $DIR/nodejs
cp $DIR/package*.json .
rm -rf node_modules
npm isntall --production
rm -rf package*.json

cd $DIR
zip -9 -r lambda-layer.zip nodejs