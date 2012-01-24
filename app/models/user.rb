class User < ActiveRecord::Base
  has_attached_file :avatar,
                    :styles => {
                      :thumb => "50x50>",
                      :small => "150x150>"
                    },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :path => ":attachment/:id/:style.:extension",
    :bucket => 'ugik_images'

end
