class AddForeignKeyToFriendships < ActiveRecord::Migration
  def change
    add_foreign_key(:friendships, :users, column: 'user_id', dependent: :delete)
    add_foreign_key(:friendships, :users, column: 'friend_id', dependent: :delete)
  end
end
