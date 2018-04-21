module SessionsHelper
  def log_in(user)
    # session[] is global variable.
    session[:uid] = user.id
    session[:username] = user.username
    session[:password] = user.password_digest
    session[:image] = user.image.url
  end

  def log_out
    session.delete(:uid)
    session.delete(:username)
    session.delete(:password)
    session.delete(:image)
    session.delete(:omniauth)
  end
end
