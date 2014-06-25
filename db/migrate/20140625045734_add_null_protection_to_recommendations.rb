class AddNullProtectionToRecommendations < ActiveRecord::Migration
  def change
    change_column :recommendations, :rottentomatoes_id, :integer, null: false
    change_column :recommendations, :recommender_id,    :integer, null: false
    change_column :recommendations, :recommendee_id,    :integer, null: false
  end
end
