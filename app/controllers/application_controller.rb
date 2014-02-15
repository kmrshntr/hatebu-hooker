class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authorize

  helper_method :current_user

  private
    def current_user
      @current_user ||= User.where(id:session[:user_id]).first if session[:user_id]
    end

    def authorize
      unless current_user
        redirect_to root_path, notice: "Please log in"
      end
    end
end
