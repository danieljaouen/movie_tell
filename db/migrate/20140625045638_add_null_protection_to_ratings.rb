class AddNullProtectionToRatings < ActiveRecord::Migration
  def change
    change_column :ratings, :rottentomatoes_id, :integer, null: false
    change_column :ratings, :rater_id,          :integer, null: false
    change_column :ratings, :rating,            :integer, null: false
  end
end
