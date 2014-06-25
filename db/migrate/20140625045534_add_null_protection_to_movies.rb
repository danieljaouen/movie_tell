class AddNullProtectionToMovies < ActiveRecord::Migration
  def change
    change_column :movies, :rottentomatoes_id, :integer, null: false
  end
end
