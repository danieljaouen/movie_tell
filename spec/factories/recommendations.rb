FactoryGirl.define do
  factory :recommendation, class: Recommendation do
    rottentomatoes_id 9559
    recommender
    recommendee
  end

  factory :recommender, class: User do
    email 'recommender@example.com'
    password 's3kr3ttt'
    password_confirmation 's3kr3ttt'
  end

  factory :recommendee, class: User do
    email 'recommendee@example.com'
    password 's3kr3ttt'
    password_confirmation 's3kr3ttt'
  end
end
