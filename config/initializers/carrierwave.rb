CarrierWave.configure do |config|
  config.aws_credentials = {
    access_key_id: ENV["AWS_ACCESS_KEY"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: "us-west-1"
  }
  config.aws_bucket = ENV["AWS_BUCKET"]
  config.aws_acl = "public-read"
end