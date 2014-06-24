FactoryGirl.define do
  factory :rating, class: Rating do
    rottentomatoes_id 9559
    rater
    rating 10
  end

  factory :rater, class: User do
    email 'rater@example.com'
    password 's3kr3ttt'
    password_confirmation 's3kr3ttt'
  end
end
