class AddForeignKeyToRecommendations < ActiveRecord::Migration
  def change
    add_foreign_key(:recommendations, :users, column: 'recommender_id', dependent: :delete)
    add_foreign_key(:recommendations, :users, column: 'recommendee_id', dependent: :delete)
  end
end
