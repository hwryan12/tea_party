class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end
  
  def create
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :created
  end
  
  def update
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.find(params[:id])
    subscription.update(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :ok
  end

  private
  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, { tea_ids: [] })
  end  
end