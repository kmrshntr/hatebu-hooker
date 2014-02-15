class SettingsController < ApplicationController

  before_action :set_user

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to action: :edit, notice: 'Event was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def show
  end

  def slack
    auth = request.env["omniauth.auth"]
    @user.slack_token = auth['credentials']['token']
    if @user.save
      redirect_to action: :edit, :notice => "Your Slack account is connected."
    end
  end

  def hatebu
    auth = request.env["omniauth.auth"]
    @user.hatena_id = auth['uid']
    if @user.save
      redirect_to action: :edit, :notice => "Your Hatena account is connected."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:hatena_bookmark_web_hook_key)
    end
end

