class AccountActivationsController < ApplicationController
  # edit account activations - GET
  def edit
    # finds the logged in user
    user = User.find_by(email: params[:email])
    # If they exist and the password is correct 
    if user && user.authenticated?(:activation, params[:id])
      # activate that user
      user.activate
      # log them in
      log_in user
      flash[:success] = 'Account Activated!'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
end
