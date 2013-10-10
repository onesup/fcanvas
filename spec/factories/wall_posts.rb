# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wall_post do
    message "행복해야돼"
    user
    options "MyText"
  end
end