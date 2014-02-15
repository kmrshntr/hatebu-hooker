class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :yammer_token
      t.string :slack_token

      t.timestamps
    end
  end
end
