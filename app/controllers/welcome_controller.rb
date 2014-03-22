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
        user_id = JSON.parse(conn.get('/api/auth.test', token: user.slack_token).body)['user_id']
        members = JSON.parse(conn.get('/api/users.list', token: user.slack_token).body)['members']
        slack_user = members.detect{|m|m["id"] == user_id}
        result = conn.post '/api/chat.postMessage', { token: user.slack_token,
          channel: 'C024YQKLA', text: text,
          username: slack_user['name'],
          icon_url: slack_user['profile']['image_48'],
          unfurl_links: 1
        }
        logger.info(result.inspect);
      end
    end
    render text: 'OK'
  end
end
