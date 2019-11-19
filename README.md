# KANMAP
![README_KANMAP](./app/assets/images/README2.png)
 
## KANMAPとは

KANMAPは地図上のお気に入りの場所の情報を共有できるサービスです。<br>
お気に入りの場所の情報を入力したKANZUMEを設置し、その中に写真やコメント等を入力したアイテムを入れると、
そのKANZUMEに誰でもアイテムを見たり、入れたりすることができます。<br>
転職活動用のポートフォリオとして制作致しました。<br>
ログイン画面に登録不要で見れる閲覧用のテストユーザーログインボタンを用意しています。<br>

## URL
[KANMAP](https://kan-map.com)
https://kan-map.com
 
## 見ていただきたい部分
 
・Dockerを使いこなし、ECS/ECRで本番環境をコンテナで実行していること<br>
・CircleCIとGitHubを連携させて自動テスト、masterブランチのみ本番環境にデプロイなど、CI/CDのパイプラインを構築していること
・assets及びユーザー画像データをS3からCloudFrontを使用してCDNで配信していること<br>
・自作ライブラリから外部APIを叩いてRailsに組み込んでいること<br>
 
## 使用技術
Ruby 2.6.3<br>
Ruby on Rails 5.2.3<br>
MySQL 8.0.17<br>
SASS<br>
AWS<br>
  ECS/ECR<br>
  EC2/ALB<br>
  RDS for MySQL<br>
  S3<br>
  CloudFront<br>
  Route53<br>
  ACM<br>
  VPC<br>
  CloudWatch<br>
  AWS<br>
Docker<br>
CircleCI<br>
GitHub<br>
Google Maps Javascript API<br>
Google Geocoding API<br>
Google Places API

 
## クラウドアーキテクチャ
 
"hoge"を動かすのに必要なライブラリなどを列挙する<br>
 
* huga 3.5.2
* hogehuga 1.0.2
 
## 開発環境
 
MacBookPro上のDocker環境で開発しています。 開発環境用イメージとそれらを起動するdocker-composeで構成されています。 docker-composeでVolumeをマウント、MySQLに関してもローカルのMySQLをマウントしています。<br>

GitHubは実際の現場の開発フローを想定しmasterブランチに直接pushせず、worksという作業用のブランチを切ってそこにPush、Masterにmergeしています。<br>
 
## CircleCI
 
CircleCIではworksではRSpecでのテスト、masterブランチではRSpecでのテストとECRへイメージのpush、ECSへの自動デプロイを行っています。 CircleCIの設定は.ciecleci/config.ymlを見て頂けるとわかるかと思います。 ECSへのデプロイにはecs-deployというツールを使用しています。<br>

最終的にmasterにmergeされてからデプロイされるまでの時間はこのようになりました。
 
## 機能一覧、使用した有名gem

Google、Twitterでの外部サービスログイン(omniauth)<br>
ユーザープロフィール画像アップロード機能<br>
投稿機能(CRUD)<br>
記事一覧表示の際のページネーション機能(kaminari)<br>
デプロイにCapistrano<br>
 
## テスト
 
RSpec<br>
統合テスト(system spec)<br>
機能テスト(request spec)<br>
単体テスト(モデル等)<br>
テストに関しましてはテストが書けることをアピールする為、全ての機能はテストしていません。 その代わりどのようなテストケースでも書けることを意識しました。<br>

## 改善点、開発してみて想定できなかった部分
<br>