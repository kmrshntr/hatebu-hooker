class WelcomeController < ApplicationController
  protect_from_forgery with: :exception, except: ["hook"]
  skip_before_filter :authorize
  def index
  end

  def about
  end

  def hook
    if user = User.where(hatena_id: params[:username]).first
      if user.can_post?(params[:key], params[:status], params[:comment].to_s)
        text = ""
        text += "#{params[:comment]} / " if params[:comment].present?
        text += "\"#{params[:title]}\"" if params[:title].present?
        text += params[:url] if params[:url].present?

        conn = Faraday.new(:url => 'https://slack.com')
        conn.post '/api/chat.postMessage', { token: user.slack_token, channel: 'C024YQKLA', text: text, username: user.name}
      end
    end
    render text: 'OK'
  end
end
