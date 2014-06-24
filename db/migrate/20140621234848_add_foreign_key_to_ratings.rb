class AddForeignKeyToRatings < ActiveRecord::Migration
  def change
    add_foreign_key(:ratings, :users, column: 'rater_id', dependent: :delete)
  end
end
