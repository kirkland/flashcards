# Thin wrapper for S3
class S3Handler
  def initialize(s3_info)
    @s3_info = s3_info
    @access_key_id = @s3_info['access_key_id']
    @secret_access_key = @s3_info['secret_access_key']
    @bucket = @s3_info['bucket']
  end

  # Store the data at key; options are passed to S3Object.store
  # (example: :content_type => 'image/gif')
  def store(key, data, public_read = false, options = {})
    establish_connection
    AWS::S3::Bucket.create(@bucket)
    AWS::S3::S3Object.store(key, data, @bucket, options)
    if public_read
      policy = AWS::S3::S3Object.acl(key, @bucket)
      policy.grants << AWS::S3::ACL::Grant.grant(:public_read)
      AWS::S3::S3Object.acl(key, @bucket, policy)
    end
  end

  # Copy the data at key to local file
  def copy(key, filename)
    establish_connection
    File.open(filename, "w+") do |f|
      AWS::S3::S3Object.stream(key, @bucket) do |chunk|
        f.write(chunk)
      end
      f.flush
    end
  end
  
  def url_for_key(key, https=false)
    proto = https ? 'https' : 'http'
    if @bucket =~ /\.com$/
      "#{proto}://#{@bucket}/#{key}"
    else
      "#{proto}://#{@bucket}.s3.amazonaws.com/#{key}"
    end
  end
  
  private
  
  def establish_connection
    unless @connection_established
      AWS::S3::Base.establish_connection!(
        :access_key_id     => @access_key_id,
        :secret_access_key => @secret_access_key
      )
      @connection_established = true
    end
  end
end
