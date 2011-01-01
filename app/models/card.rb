class Card < ActiveRecord::Base
  belongs_to :deck
  attr_accessor :should_destroy
  validates_presence_of :front, :back
  has_attached_file :sound, 
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS, 
    :bucket => S3_BUCKET, 
    :path => "card_sounds/:id.:extension"

  def should_destroy?
    should_destroy.to_i == 1
  end
end
