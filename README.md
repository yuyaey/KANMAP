# KANMAP
![README_KANMAP](./app/assets/images/README2.png)
 
## KANMAPとは

KANMAPは地図上のお気に入りの場所の情報を共有できるサービスです。
お気に入りの場所の情報を入力したKANZUMEを設置し、その中に写真やコメント等を入力したアイテムを入れると、
そのKANZUMEに誰でもアイテムを見たり、入れたりすることができます。
転職活動用のポートフォリオとして制作致しました。
ログイン画面に登録不要で見れる閲覧用のテストユーザーログインボタンを用意しています。

## URL
[KANMAP](https://kan-map.com)
https://kan-map.com
 
## 見ていただきたい部分
 
・Dockerを使いこなし、ECS/ECRで本番環境をコンテナで実行していること
CircleCIとGitHubを連携させて自動テスト、masterブランチのみ本番環境にデプロイなど、CI/CDのパイプラインを構築していること
・assets及びユーザー画像データをS3からCloudFrontを使用してCDNで配信していること
・自作ライブラリから外部APIを叩いてRailsに組み込んでいること
 
## 使用技術
Ruby 2.6.3
Ruby on Rails 5.2.3
MySQL 8.0.17
SASS
AWS
  ECS/ECR
  EC2/ALB
  RDS for MySQL
  S3
  CloudFront
  Route53
  ACM
  VPC
  CloudWatch
  AWS
Docker
CircleCI
GitHub
Google Maps Javascript API
Google Geocoding API
Google Places API

 
## クラウドアーキテクチャ
 
"hoge"を動かすのに必要なライブラリなどを列挙する
 
* huga 3.5.2
* hogehuga 1.0.2
 
## 開発環境
 
MacBookPro上のDocker環境で開発しています。 開発環境用イメージとそれらを起動するdocker-composeで構成されています。 docker-composeでVolumeをマウント、MySQLに関してもローカルのMySQLをマウントしています。

GitHubは実際の現場の開発フローを想定しmasterブランチに直接pushせず、worksという作業用のブランチを切ってそこにPush、Masterにmergeしています。
 
## CircleCI
 
CircleCIではworksではRSpecでのテスト、masterブランチではRSpecでのテストとECRへイメージのpush、ECSへの自動デプロイを行っています。 CircleCIの設定は.ciecleci/config.ymlを見て頂けるとわかるかと思います。 ECSへのデプロイにはecs-deployというツールを使用しています。

最終的にmasterにmergeされてからデプロイされるまでの時間はこのようになりました。
 
## 機能一覧、使用した有名gem

Google、Twitterでの外部サービスログイン(omniauth)
ユーザープロフィール画像アップロード機能
投稿機能(CRUD)
記事一覧表示の際のページネーション機能(kaminari)
デプロイにCapistrano
 
## テスト
 
RSpec
統合テスト(system spec)
機能テスト(request spec)
単体テスト(モデル等)
テストに関しましてはテストが書けることをアピールする為、全ての機能はテストしていません。 その代わりどのようなテストケースでも書けることを意識しました。

## 改善点、開発してみて想定できなかった部分
