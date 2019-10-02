if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = 'AWS'
    config.aws_access_key_id = "AKIA5BYIIW7VVXG77TFW"
    config.aws_secret_access_key = "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"
    config.fog_directory = "kanmap-pictures"
    config.fog_region = "ap-northeast-1"
    config.gzip_compression = true
  end
end