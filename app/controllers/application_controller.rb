require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  before_action :authorize

  # this is to use SessionsHelper
  include SessionsHelper

  # this is to check already login or not.
  def authorize
    unless User.find_by(username: session[:username])
      redirect_to controller: "sessions", action: "new"
    end
  end

  private

    def current_user
      # if session[:uid] = nil, @current_user = User.find(session[:uid])
      # if session[:uid] != nil, @current_user is not change.
      @current_user ||= User.find(session[:uid]) if session[:uid]
        # if session[:uid]
        #   @current_user = User.find(session[:uid])
        # end
    end

    helper_method :current_user

end
