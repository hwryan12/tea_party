class Api::V1::SubscriptionsController < ApplicationController
  before_action :set_customer
  
  def index
    subscriptions = @customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end
  
  def create
    subscription = @customer.subscriptions.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :created
  end
  
  def update
    subscription = @customer.subscriptions.find(params[:id])
    subscription.update(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :ok
  end

  private
  
  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, { tea_ids: [] })
  end  
end