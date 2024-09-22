---
tags:
  - AWS/lambda
---

LambdaWebAdapterとCloudFront併用におけるキャッシュ戦略

Nextのキャッシュを使う方法に関しては2通り

[Next.js 13 の SSR Streaming を AWS Lambda Response Streaming で...](https://aws.amazon.com/jp/blogs/news/implementing-ssr-streaming-on-nextjs-with-aws-lambda-response-streaming/)
上記では、CloudFrontとlambdaのみを併用し、Caching Optimizedを使用することで
nextjsが付与するcache-control headerを利用して自動的に適当なキャッシュが効くようにしている
~~この方法ではOACによるアクセス制限ができないため、lambda function urlへの直接のアクセスを制限できない~~
→最近のupdateで、function urlにもOACが適用可能になったそう
[AWS Lambda Function URLs（関数URL）がCloudfrontのOACに対応したので試す #lam...](https://qiita.com/Kanahiro/items/85573c9ae724df435a6a)

~~nextjsでのミドルウェアを使用して自前で検証することが提案されている
こちらはlambda function urlを使わず、別の方法で解決できないか？
例えばAPI Gatewayを使う、などで解決できないかを下記のハンズオンで学びたい~~
[AWS Hands-on for Beginners Amazon CloudFrontおよびAWS WAFを用いて エ...](https://pages.awscloud.com/JAPAN-event-OE-Hands-on-for-Beginners-CF_WAF-2022-reg-event.html?trk=aws_introduction_page)

[Dockerを使わない、Remix / Next.js 14 など最新ウェブフレームワークのAWS完全サーバーレス構成と...](https://serverless.co.jp/blog/g30vzpio0ww/)
こちらはpublicなどの画像をそもそものビルドに含めず、S3にアップロードすることでlambdaから出ていくデータ伝送量を抑える方法が提案されている

lambda functionへのURL直アクセスがlambda@edgeの起動により対応可能とのこと
[Serving SSE-KMS encrypted content from S3 using CloudFront |...](https://aws.amazon.com/jp/blogs/networking-and-content-delivery/serving-sse-kms-encrypted-content-from-s3-using-cloudfront/)
ただ、lambda edgeは通常のlambdaの料金の3倍