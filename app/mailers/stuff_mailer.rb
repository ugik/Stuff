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
    if message.body.decoded.include? 'confirmation code'	# handle email forwarding verification
        puts message.body.decoded
    end

    mail = MMS2R::Media.new(message)        # process mail to handle MMS if sent from phone

    if mail.is_mobile?
        @subject = "<None>"
	@email = "SomeOne@example.com"	# placeholder
        puts "mail was from phone #{mail.number} of type #{mail.device_type?}"
        file = mail.default_text
	text = IO.readlines(mail.media['text/plain'].first).join
	puts "mail had text: #{text}" unless text.nil?
        @subject = text unless text.nil?
        file = mail.default_media
        puts "mail had a media: #{file.inspect}" unless file.nil?
	puts "but media was text" unless !file.to_s.include? '.txt'
	avatar_file = file

    else
	@subject = message.subject
	@email = message.from[0].to_s	# first address in array

        # Create an AttachmentFile subclass of a tempfile with paperclip aware features and add it
	if attachment!=nil
	        avatar_file = AttachmentFile.new('test.jpg')
        	avatar_file.write attachment.decoded.force_encoding("utf-8")
      		avatar_file.flush
        	avatar_file.original_filename = attachment.filename
        	avatar_file.content_type = attachment.mime_type
	end
    end

    puts @email + " : " + @subject
    puts "**************************"

    # Create the user
    User.create do |user|

      user.name = @subject
      user.email = @email
      user.avatar = avatar_file unless avatar_file.nil?

#      UserMailer.registration_confirmation(user).deliver

    end
  end
end

