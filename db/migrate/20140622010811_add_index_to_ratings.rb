class AddIndexToRatings < ActiveRecord::Migration
  def change
    add_index :ratings, :rater_id
  end
end
