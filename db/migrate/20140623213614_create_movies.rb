class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :rottentomatoes_id
      t.string :title
      t.string :year
      t.string :mpaa_rating
      t.integer :critics_score
      t.integer :audience_score

      t.timestamps
    end
  end
end
