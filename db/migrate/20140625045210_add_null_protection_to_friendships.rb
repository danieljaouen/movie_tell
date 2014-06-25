class AddNullProtectionToFriendships < ActiveRecord::Migration
  def change
    change_column :friendships, :user_id,   :integer, null: false
    change_column :friendships, :friend_id, :integer, null: false
    change_column :friendships, :pending,   :boolean, null: false
  end
end
