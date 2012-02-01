class UserMailer < ActionMailer::Base
  default :from => "ugikma@gmail.com"

	def registration_confirmation(name, email)
		mail(:to => "#{name} <#{email}>", :subject => "Registered")
	end

	def receipt_confirmation(name, email)
		mail(:to => "#{name} <#{email}>", :subject => "Received")
	end

end

