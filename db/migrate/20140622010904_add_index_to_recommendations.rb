class AddIndexToRecommendations < ActiveRecord::Migration
  def change
    add_index :recommendations, :recommender_id
    add_index :recommendations, :recommendee_id
  end
end
