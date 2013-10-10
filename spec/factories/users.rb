FactoryGirl.define do
  factory :user do
    uid "100001176058018"
    trait :without_token do
      
    end
    trait :with_token do
      name "Wonsup Lee"
      token
    end
    factory :with_token_user, traits: [:with_token]
  end
end
