class UserMailer < ActionMailer::Base
  default :from => "ugikma@gmail.com"

	def registration_confirmation(user)
		mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
	end

	def receipt_confirmation(user)
		mail(:to => "#{user.name} <#{user.email}>", :subject => "Received")
	end

end

