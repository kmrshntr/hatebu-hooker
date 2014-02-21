class WelcomeController < ApplicationController
  protect_from_forgery with: :exception, except: ["hook"]
  skip_before_filter :authorize
  def index
  end

  def about
  end

  def hook
    if user = User.where(hatena_id: params[:username]).first 
      if user.hatena_bookmark_web_hook_key == params[:key] && params[:status] == "add"
        conn = Faraday.new(:url => 'https://slack.com')
        text = ""
        if params[:comment].present?
          text += params[:comment].to_s + " / "
        end
        if params[:title].present?
          text += '"' + params[:title]+'" '
        end
        if params[:url].present?
          text += params[:url]
        end
        conn.post '/api/chat.postMessage', { token: user.slack_token, channel: 'C024YQKLA', text: text, username: user.name}
      end
    end
    render text: 'OK'
  end
end
