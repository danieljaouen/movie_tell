class AddIndexToUserProfileUserId < ActiveRecord::Migration
  def change
    add_index :user_profiles, :user_id, unique: true
  end
end
