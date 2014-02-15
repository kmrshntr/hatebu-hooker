Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yammer, ENV['YAMMER_KEY'], ENV['YAMMER_SECRET']
  provider :slack, ENV['SLACK_KEY'], ENV['SLACK_SECRET'], scope: "identify,read,post"
  provider :hatena, ENV['HATENA_KEY'], ENV['HATENA_SECRET']
end
