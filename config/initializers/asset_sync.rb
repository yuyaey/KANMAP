if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = 'AWS'
    config.aws_access_key_id = Rails.application.credentials.aws[:access_key_id]
    config.aws_secret_access_key = Rails.application.credentials.aws[:secret_access_key]
    config.fog_directory = "kanmap-pictures"
    config.fog_region = "ap-northeast-1"
    config.gzip_compression = true
  end
end