FactoryGirl.define do
  factory :taco do
    meat { ["chicken", "steak"].sample }
  end
end