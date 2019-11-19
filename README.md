# KANMAP
 
KANMAPとは

eスポーツプレイヤーがゲームについての知識、戦略などを情報交換しあうwebサービスです。 転職活動用のポートフォリオとして制作致しました。

# URL
https://kan-map.com
 
# 見ていただきたい部分
 
Dockerを使いこなし、ECS/ECRで本番環境をコンテナで実行していること
CircleCIとGitHubを連携させて自動テスト、masterブランチのみ本番環境にデプロイなど、CI/CDのパイプラインを構築していること
assets及びユーザー画像データをS3からCloudFrontを使用してCDNで配信していること
自作ライブラリから外部APIを叩いてRailsに組み込んでいること
 
# 使用技術
 
Ruby 2.4.0
Ruby on Rails 5.2.2
MySQL 5.7.25
SASS
AWS
ECS/ECR
EC2/ALB
RDS for MySQL
S3
CloudFront
SES
Route53
Certificate Manager
VPC
CloudWatch
Docker
CircleCI
ecs-deploy
GitHub
 
# クラウドアーキテクチャ
 
"hoge"を動かすのに必要なライブラリなどを列挙する
 
* huga 3.5.2
* hogehuga 1.0.2
 
# 開発環境
 
MacBookPro上のDocker環境で開発しています。 開発環境用イメージとそれらを起動するdocker-composeで構成されています。 docker-composeでVolumeをマウント、MySQLに関してもローカルのMySQLをマウントしています。

GitHubは実際の現場の開発フローを想定しmasterブランチに直接pushせず、worksという作業用のブランチを切ってそこにPush、Masterにmergeしています。
 
# CircleCI
 
CircleCIではworksではRSpecでのテスト、masterブランチではRSpecでのテストとECRへイメージのpush、ECSへの自動デプロイを行っています。 CircleCIの設定は.ciecleci/config.ymlを見て頂けるとわかるかと思います。 ECSへのデプロイにはecs-deployというツールを使用しています。

最終的にmasterにmergeされてからデプロイされるまでの時間はこのようになりました。
 
# 機能一覧、使用した有名gem
ユーザー登録、ログイン機能全般、パスワードを忘れた際のメール配信(devise)
Twitter、Twitchでの外部サービスログイン(omniauth)
ユーザープロフィール画像アップロード機能
ユーザー間でのフォローフォロワー機能
記事投稿機能(CRUD)
記事一覧表示の際のページネーション機能(kaminari)
外部API(Twitch)を叩いてコンテンツを表示
人気記事ランキング表示機能
いいね機能
管理画面(ActiveAdmin)
 
# テスト
 
RSpec
統合テスト(system spec)
機能テスト(request spec)
単体テスト(モデル等)
テストに関しましてはテストが書けることをアピールする為、全ての機能はテストしていません。 その代わりどのようなテストケースでも書けることを意識しました。

# 改善点、開発してみて想定できなかった部分

issueにもありますが結構解決できてないbugが結構あります。
Dockerfileが重すぎる、pushやbuildに時間がかかりすぎているので軽量化したい。Alpine Linuxを使っているRubyイメージが公式にあるのでそれを使えば軽くなりそう。apt-get updateで入るnodeのバージョンが低く手動でアップデートしているのでその辺も解決できそう
CSSフレームワークを使用するべきだった。設計段階ではBootstrapも視野に入れていたが、Bootstrap臭さがどうしても残る為オリジナルのデザインにしたかった。 実際書いて見るとSASSを使っているにしてもCSSのコーディングに想定以上に時間が掛かってしまった。 バックエンドエンジニアを目指しているのでフロントエンド面は簡潔にするべきだった。
インフラ等の非機能要件は充実しているが、それに比べ実際のアプリの機能面で見るとチープに見えてしまいポートフォリオとしてのインパクトが欠けてしまったように思える。