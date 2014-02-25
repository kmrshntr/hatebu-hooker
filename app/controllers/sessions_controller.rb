class SessionsController < ApplicationController

  skip_before_filter :authorize, :only => [:create]

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_by(email:auth['info']['email'])
    user.name = auth['info']['nickname']
    user.yammer_token = auth[:credentials][:token]
    user.save
    session[:user_id] = user.id
    redirect_to root_path, :notice => "Hello #{user.name}."
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "You successfully logged out."
  end

end
