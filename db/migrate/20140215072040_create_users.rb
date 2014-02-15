class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :yammer_token
      t.string :hatena_id
      t.string :hatena_bookmark_web_hook_key
      t.string :slack_token

      t.timestamps
    end
  end
end
