module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember 
    cookies.permanent.signed[:user_id] = user.id # .signed encrypts the cookie on its way in
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    # if session user id exists, set it to user_id
    if (user_id = session[:user_id]) 
      # set the current user to the one found in the db
      @current_user ||= User.find_by(id: user_id)
      # session is gone, but persistent cookie remains 
    elsif (user_id = cookies.signed[:user_id])
      # find the user in the db
      user = User.find_by(id: user_id)
      # if the user exists and clicked rememember me before
      if user && user.authenticated?(cookies[:remember_token])
        # sign them in
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default) 
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    # stores the forwarding url from the request url if its a GET
    # we can access the location the user is trying to access from the session after this storage.
    session[:forwarding_url] = request.original_url if request.get?
  end
end
