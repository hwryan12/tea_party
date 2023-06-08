require 'rails_helper'

RSpec.describe 'Customers Subscriptions API', type: :request do
  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }

  let!(:tea1) { create(:tea) }
  let!(:tea2) { create(:tea) }  

  let!(:subscription1) { create(:subscription, customer: customer1, teas: [tea1, tea2]) }
  let!(:subscription2) { create(:subscription, customer: customer1, teas: [tea1]) }
  let!(:subscription3) { create(:subscription, customer: customer2, teas: [tea2]) }

  describe 'POST /api/v1/customers/:id/subscriptions' do
    let (:valid_attributes) do
      {
        subscription: {
          title: "Monthly Tea Subscription",
          price: 15.99,
          status: "active",
          frequency: "monthly",
          customer_id: customer1.id,
          tea_ids: [tea1.id]
        }
      }
    end

    context 'when the request is valid' do
      before { post "/api/v1/customers/#{customer1.id}/subscriptions", params: valid_attributes }

      it 'creates a subscription' do
        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(:created)
        expect(json[:data]).to be_a(Hash)
        expect(json[:data]).to have_key(:id)
        expect(json[:data][:attributes][:title]).to eq('Monthly Tea Subscription')
        expect(json[:data][:attributes][:price]).to eq('15.99')
        expect(json[:data][:attributes][:status]).to eq('active')
        expect(json[:data][:attributes][:frequency]).to eq('monthly')
        expect(json[:data][:attributes][:customer_id]).to eq(customer1.id)
        expect(json[:data][:attributes][:tea_ids]).to eq([tea1.id])
      end
    end

    context 'when the request is missing a necessary attribute' do
      before do
        invalid_attributes = valid_attributes.deep_dup
        invalid_attributes[:subscription].delete(:title)
        post "/api/v1/customers/#{customer1.id}/subscriptions", params: invalid_attributes
      end      
    
      it 'returns a validation failure message' do
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:errors]).to include("Title can't be blank")
      end
    end

    context 'when the customer does not exist' do
      let(:non_existent_id) { 10000 } 
      before { post "/api/v1/customers/#{non_existent_id}/subscriptions", params: valid_attributes }
    
      it 'returns a not found message' do
        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:error]).to eq('Customer not found')
      end
    end
  end

  describe 'PUT /api/v1/customers/:id/subscriptions/:id' do
    let(:subscription) { create(:subscription, customer: customer, status: 'active') }

    context 'when the subscription exists' do
      before { put "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}", params: { subscription: { status: 'cancelled' } } }

      it 'cancels the subscription' do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:ok)
        expect(json[:data][:attributes][:status]).to eq('cancelled')
      end
    end
  end

  describe 'GET /api/v1/customers/:id/subscriptions' do
    context 'when the customer exists' do
      before { get "/api/v1/customers/#{customer1.id}/subscriptions" }

      it 'returns all of the customers subscriptions' do
        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(:ok)
        expect(json[:data].count).to eq(2)
        
        expect(json[:data].first[:attributes][:title]).to eq(subscription1.title)
        expect(json[:data].first[:attributes][:price]).to eq(subscription1.price.to_s)
        expect(json[:data].first[:attributes][:status]).to eq(subscription1.status)
        expect(json[:data].first[:attributes][:frequency]).to eq(subscription1.frequency)
        expect(json[:data].first[:attributes][:customer_id]).to eq(subscription1.customer_id)
        expect(json[:data].first[:attributes][:tea_ids]).to eq([tea1.id, tea2.id])
        
        expect(json[:data].last[:attributes][:title]).to eq(subscription2.title)
        expect(json[:data].last[:attributes][:price]).to eq(subscription2.price.to_s)
        expect(json[:data].last[:attributes][:status]).to eq(subscription2.status)
        expect(json[:data].last[:attributes][:frequency]).to eq(subscription2.frequency)
        expect(json[:data].last[:attributes][:customer_id]).to eq(subscription2.customer_id)
        expect(json[:data].last[:attributes][:tea_ids]).to eq([tea1.id])
      end
    end
  end
end