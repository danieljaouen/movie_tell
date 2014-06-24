FactoryGirl.define do
  factory :admin, class: Admin do
    email 'admin@example.com'
    password 's3kr3ttt'
    password_confirmation 's3kr3ttt'
  end
end
