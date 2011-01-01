require 's3_handler'
S3_HANDLER = S3Handler.new YAML.load_file(Rails.root.join('config', 'amazon_s3.yml'))[Rails.env]