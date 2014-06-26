class AddForeignKeyToUserProfile < ActiveRecord::Migration
  def change
    add_foreign_key(:user_profiles, :users, column: 'user_id', dependent: :delete)
  end
end
