FactoryBot.define do
  factory :subscription do
    title { "Monthly Tea Subscription" }
    price { 15.99 }
    status { "active" }
    frequency { "monthly" }
    customer
  end
end
