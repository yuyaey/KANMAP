CarrierWave.configure do |config|
   if Rails.env.production?

      config.fog_provider = 'fog/aws'
      config.fog_credentials = {
        provider:              'AWS',
        # アクセスキー
        aws_access_key_id:     Rails.application.credentials.aws[:access_key_id],
        # シークレットキー
        aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
        # Tokyo
        region:                'ap-northeast-1',
      }

      # 公開・非公開の切り替え
      config.fog_public     = true
      # キャッシュの保存期間
      config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }

      # キャッシュをS3に保存
      config.cache_storage = :fog

      # S3のバケットを指定
      config.fog_directory = 'kanmap-pictures'
      config.asset_host = 'https://d1oc5iua8d0deu.cloudfront.net'

    else

      config.storage :file # 開発環境:public/uploades下に保存
      config.enable_processing = false if Rails.env.test? #test:処理をスキップ
    end
end

# 日本語ファイル名の設定
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/