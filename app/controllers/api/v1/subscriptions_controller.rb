class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.create!(subscription_params.except(:tea_ids))
  
    if subscription_params[:tea_ids]
      subscription_params[:tea_ids].each do |tea_id|
        SubscriptionTea.create!(subscription: subscription, tea_id: tea_id)
      end
    end
  
    render json: SubscriptionSerializer.new(subscription).serializable_hash.to_json, status: :created
  end
  
  def update
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    render json: SubscriptionSerializer.new(subscription).serializable_hash.to_json, status: :ok
  end

  private
  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, { tea_ids: [] })
  end  
end