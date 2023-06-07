class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions)
  end
  
  def create
    subscription = Subscription.create!(subscription_params)
  
    if subscription_params[:tea_ids]
      subscription_params[:tea_ids].each do |tea_id|
        SubscriptionTea.create!(subscription: subscription, tea_id: tea_id)
      end
    end
  
    render json: SubscriptionSerializer.new(subscription), status: :created
  end
  
  def update
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :ok
  end

  private
  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, { tea_ids: [] })
  end  
end