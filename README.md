# KANMAP
![README_KANMAP](./app/assets/images/README2.png)
 
## KANMAPとは

KANMAPは地図上のお気に入りの場所の情報を共有できるサービスです。<br>
転職活動用のポートフォリオとして制作致しました。<br>

## サイトページ
[KANMAP](https://kan-map.com)　<br>
トップ画面に登録不要で見れる閲覧用のテストユーザーログインボタンを用意しています。<br>

## 見ていただきたい部分
* インフラにAWSの各種サービスを活用しています。<br>
* Capistrano、CircleCIとGitHubを連携させて自動テスト、masterブランチのみ本番環境にデプロイ等、CI/CDのパイプラインを構築しています。
* 画像はS3に保存し、CloudFrontでCDN配信を行っています。<br>
 
## 使用技術
* Ruby 2.6.3<br>
* Ruby on Rails 5.2.3<br>
* MySQL 8.0.17<br>
* SASS<br>
* Materialize<br>
* AWS<br>
  * EC2/ALB<br>
  * RDS for MySQL<br>
  * S3<br>
  * CloudFront<br>
  * Route53<br>
  * ACM<br>
  * VPC<br>
  * CloudWatch<br>
  * AWS<br>
* Docker<br>
* CircleCI<br>
* Capistrano<br>
* Nginx<br>
* Unicorn<br>
* Google Maps Javascript API<br>
* Google Geocoding API<br>
* Google Places API<br>


## 機能一覧(使用gem)
* Rspecによる自動テスト機能
* Capistranoによるデプロイ機能
* CircleCIによるCI/CI機能
* Google、Twitterでの外部サービスログイン(omniauth)<br>
* 画像アップロード機能(carrierWave,rmagic,fog-aws)<br>
* 投稿機能CRUD<br>
* 記事一覧表示の際のページネーション機能(kaminari)<br>
* 検索機能(Ransack)<br>
* 管理ユーザー機能
* GoogleAPIを用いた現在地特定、キーワード検索、ジオコーディング機能<br>
 
## クラウドアーキテクチャ
![README_Architecutre](./app/assets/images/CloudArchitecture.jpg)
 
## 開発環境
MacBookPro上のDocker環境で開発しています。 開発環境用イメージとそれらを起動するdocker-composeで構成されています。 docker-composeでVolumeをマウント、MySQLに関してもローカルのMySQLをマウントしています。<br>


## 改善点
* Dockerの導入は開発環境のみに留まっており、本番環境に導入できていない。ECSやBeanstalk等のコンテナ基盤の使用を課題としたい。
* 主にフロント周りにおいてコードの重複や無駄があり、十分なリファクタリングができていない。
* テストが一部しか書けていない。