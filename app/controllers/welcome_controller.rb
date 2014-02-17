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
        res = conn.get("/api/users.list?token=#{user.slack_token}")
        members = JSON.parse(res.body)['members']
        username = members.detect{|member| member['profile']['email'] == user.email}['name']
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
        conn.post '/api/chat.postMessage', { token: user.slack_token, channel: 'G024ZC07C', text: text, username: username}
      end
    end
    render text: 'OK'
  end
end
