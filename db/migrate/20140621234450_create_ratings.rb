class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rottentomatoes_id
      t.integer :rater_id
      t.integer :rating

      t.timestamps
    end
  end
end
