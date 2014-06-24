class AddIndexToMovies < ActiveRecord::Migration
  def change
    add_index :movies, :rottentomatoes_id, unique: true
  end
end
