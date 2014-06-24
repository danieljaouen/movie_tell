class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :rottentomatoes_id
      t.integer :recommender_id
      t.integer :recommendee_id

      t.timestamps
    end
  end
end
