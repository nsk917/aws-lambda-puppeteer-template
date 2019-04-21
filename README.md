# aws-lambda-puppeteer-template

AWS Lambda で puppeteer を動かすためのテンプレート

# env

必須

- Nodejs 8.10 >=
- aws cli

必要であれば

- docker

# how to use

とりあえず動かしたい方向け  
IAM Role を作成するので `--capabilities CAPABILITY_IAM` を忘れずに

```
RAND=$(openssl rand -hex 10)
aws s3 mb s3://aws-lambda-layer-$RAND --region ap-northeast-1

npm run zip-layer
aws s3 cp lambda-layer.zip s3://aws-lambda-layer-$RAND

npm run zip-code
aws s3 cp function-code.zip s3://aws-lambda-layer-$RAND

aws cloudformation deploy --stack-name aws-lambda-puppeteer --template-file template.yaml --capabilities CAPABILITY_IAM --parameter-overrides S3Bucket=aws-lambda-layer-$RAND
```

# testing

テストには [docker-lambda](https://github.com/lambci/docker-lambda) を使う  
Linux のほうは動作するかどうか確かめたことはない

```
# WSL (Windows Subsystem for Linux)
docker run --rm --mount type=bind,src=C:/<path>/aws-lambda-puppeteer-template,dst=/var/task lambci/lambda:nodejs8.10 index.handler

# Linux
docker run --rm --mount type=bind,src=$(pwd),dst=/var/task lambci/lambda:nodejs8.10 index.handler
```

# reference

AWS Serverless Application Model (SAM)  
https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md
