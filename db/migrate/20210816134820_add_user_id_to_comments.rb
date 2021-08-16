class AddUserIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :user_id, :uuid, null: false, foreign_key: true
  end
end
