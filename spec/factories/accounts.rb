FactoryBot.define do
  factory :account do
    user
    authorization
    plaid_institution

    trait :archived do
      archived true
    end
  end
end
