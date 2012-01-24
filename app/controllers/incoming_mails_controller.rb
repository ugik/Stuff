class IncomingMailsController < ApplicationController    
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def create
    message = Mail.new(params[:message])

    logger.debug(message.subject)
    logger.debug(message.body.decoded)

    # Do some other stuff with the mail message

    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
end

