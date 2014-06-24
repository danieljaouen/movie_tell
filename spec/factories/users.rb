FactoryGirl.define do
  factory :user1, class: User do
    email 'user1@example.com'
    password 's3kr3ttt'
    password_confirmation 's3kr3ttt'
  end

  factory :user2, class: User do
    email 'user2@example.com'
    password 's3kr3ttt'
    password_confirmation 's3kr3ttt'
  end

  factory :user3, class: User do
    email 'user3@example.com'
    password 's3kr3ttt'
    password_confirmation 's3kr3ttt'
  end

  factory :user4, class: User do
    email 'user4@example.com'
    password 's3kr3ttt'
    password_confirmation 's3kr3ttt'
  end
end
