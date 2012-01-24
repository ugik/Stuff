class StuffMailer < ActionMailer::Base
  # Create an attachment file with some paperclip aware features
  class AttachmentFile < Tempfile
    attr_accessor :original_filename, :content_type
  end

  # Called whenever a message is received on the movies controller
  def receive(message)
    # For now just take the first attachment and assume there is only one
    attachment = message.attachments.first

#    logger.debug(message.subject)
#    logger.debug(message.attachments.count)

    # Create the movie itself
    User.create do |user|

      logger.debug("***********************************")
      logger.debug(message.from
      logger.debug(message.from.split(' ')
      logger.debug(message.from.split(' ').last
      logger.debug("***********************************")

      user.name = message.subject
      user.email = message.from.split(' ').last	    # extract email from end of 'from' text

      # Create an AttachmentFile subclass of a tempfile with paperclip aware features and add it
      avatar_file = AttachmentFile.new('test.jpg')
      avatar_file.write attachment.decoded.force_encoding("utf-8")
      avatar_file.flush
      avatar_file.original_filename = attachment.filename
      avatar_file.content_type = attachment.mime_type
      user.avatar = avatar_file
    end
  end
end

