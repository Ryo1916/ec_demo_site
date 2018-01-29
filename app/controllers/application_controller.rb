require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  before_action :authorize


  # this is to check already login or not.
  def authorize
    unless User.find_by(username: session[:username])
      redirect_to controller: "sessions", action: "new"
    end
  end

end
