class Api::V1::SubscriptionsController < ApplicationController
  before_action :set_customer
  
  def index
    subscriptions = @customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end
  
  def create
    subscription = @customer.subscriptions.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def update
    subscription = @customer.subscriptions.find_by(id: params[:id])
    if subscription.nil?
      render json: { error: 'Subscription not found' }, status: :not_found
    elsif subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(subscription), status: :ok
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  
  def set_customer
    @customer = Customer.find(params[:customer_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Customer not found' }, status: :not_found
  end

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, { tea_ids: [] })
  end  
end