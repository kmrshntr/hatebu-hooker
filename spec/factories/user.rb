FactoryGirl.define do
  factory :user do
    name                "test"
    email               "text@example.com"
    yammer_token        "tokentoken"
    hatena_id           "hatebu"
    hatena_bookmark_web_hook_key  "hatebu_key"
    slack_token         "slack-token"
  end
end
