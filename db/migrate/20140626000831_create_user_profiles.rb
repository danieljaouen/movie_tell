class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.boolean :private, null: false
      t.boolean :show_ratings, null: false

      t.timestamps
    end
  end
end
