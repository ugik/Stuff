class UserMailer < ActionMailer::Base
  default :from => "ugikma@gmail.com"

	def registration_confirmation(user, email)
		@user = user
		mail(:to => "#{user.name} <#{email}>", :subject => "Registered")
	end

	def receipt_confirmation(user, email)
		@user = user
		mail(:to => "#{user.name} <#{email}>", :subject => "Received")
	end

end

