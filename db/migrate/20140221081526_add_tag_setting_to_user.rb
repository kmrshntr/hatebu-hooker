class AddTagSettingToUser < ActiveRecord::Migration
  def change
    add_column :users, :include_tags, :string
    add_column :users, :exclude_tags, :string
  end
end
