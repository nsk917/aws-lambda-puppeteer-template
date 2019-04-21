#!/bin/bash -x

DIR=$(cd $(dirname $0); pwd)
mkdir $DIR/nodejs
cp $DIR/package*.json $DIR/nodejs/
rm -rf $DIR/nodejs/node_modules

cd $DIR/nodejs
npm isntall --production
rm -rf $DIR/nodejs/package*.json

cd $DIR
zip -9 -r lambda-layer.zip nodejs