FactoryGirl.define do
  factory :profiler, class: User do
    email 'profiler@example.com'
    password 's3kr3ttt'
    password_confirmation 's3kr3ttt'
  end

  factory :user_profile do
    association :user, factory: :profiler
    name 'Pro Filer'
    private false
    show_ratings false
  end
end
