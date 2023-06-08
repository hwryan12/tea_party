class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :price, :status, :frequency, :customer_id
  attribute :tea_ids do |subscription|
    subscription.teas.pluck(:id)
  end
end
