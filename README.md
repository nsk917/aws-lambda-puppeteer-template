# aws-lambda-puppeteer-template

AWS Lambda で puppeteer を動かすためのテンプレート

## Env

必須

- Nodejs 8.10 >=
- aws cli

必要であれば

- docker

## How to use

とりあえず動かしたい方向け  
IAM Role を作成するので `--capabilities CAPABILITY_IAM` を忘れずに

```bash
RAND=$(openssl rand -hex 10)
aws s3 mb s3://aws-lambda-layer-$RAND --region ap-northeast-1

npm run zip-layer

aws cloudformation package \
 --template-file template.yaml \
 --s3-bucket aws-lambda-layer-$RAND \
 --output-template-file deploy.yaml

aws cloudformation deploy \
 --stack-name aws-lambda-puppeteer \
 --template-file deploy.yaml \
 --capabilities CAPABILITY_IAM \
 --no-fail-on-empty-changeset
```

## Testing

テストには [docker-lambda](https://github.com/lambci/docker-lambda) を使う
Linux のほうは動作するかどうか確かめたことはない

```bash
# WSL (Windows Subsystem for Linux)
docker run --rm --mount type=bind,src=C:/<path>/aws-lambda-puppeteer-template,dst=/var/task lambci/lambda:nodejs8.10 index.handler

# Linux
docker run --rm --mount type=bind,src=$(pwd),dst=/var/task lambci/lambda:nodejs8.10 index.handler
```

## Reference

PuppeteerをAWS Lambda上で動かすためのテンプレートを作った
https://qiita.com/ns_k/items/ded8d51627005bd8309a

AWS Serverless Application Model (SAM)  
https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md

chrome-aws-lambda  
https://github.com/alixaxel/chrome-aws-lambda

chrome-aws-lambda を使う理由  
https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-on-aws-lambda

AWS Lambda ( Typescript ) の Lambda Layers 活用、開発、デプロイ考察  
https://dev.classmethod.jp/server-side/serverless/aws-lambda-typescript-lambda-layers-deploy/
