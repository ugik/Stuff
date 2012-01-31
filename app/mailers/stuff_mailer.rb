class StuffMailer < ActionMailer::Base
  # Create an attachment file with some paperclip aware features
  class AttachmentFile < Tempfile
    attr_accessor :original_filename, :content_type
  end

  # Called whenever a message is received on the movies controller
  def receive(message)
    # For now just take the first attachment and assume there is only one
    attachment = message.attachments.first

    puts "**************************"

    mail = MMS2R::Media.new(message)
    puts "mail has default carrier subject" if mail.subject.empty?
    puts "mail was from phone #{mail.number}"
    file = mail.default_text
    puts "mail had some text: #{file.inspect}" unless file.nil?

    puts message.subject
    puts message.from[0].to_s

    # Create the movie itself
    User.create do |user|

      user.name = message.subject
      user.email = message.from[0].to_s    # first email address in 'from' array

      # Create an AttachmentFile subclass of a tempfile with paperclip aware features and add it
      avatar_file = AttachmentFile.new('test.jpg')
      avatar_file.write attachment.decoded.force_encoding("utf-8")
      avatar_file.flush
      avatar_file.original_filename = attachment.filename
      avatar_file.content_type = attachment.mime_type
      user.avatar = avatar_file

#      UserMailer.registration_confirmation(user).deliver

    end
  end
end

