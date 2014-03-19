# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :journey do
    title "JourneyTitle"

    association :value_proposition, strategy: :build
  end
end
