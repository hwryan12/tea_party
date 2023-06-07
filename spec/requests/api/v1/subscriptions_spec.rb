require 'rails_helper'

RSpec.describe 'Subscriptions API', type: :request do
  let!(:customer) { create(:customer) }
  let!(:tea) { create(:tea) }

  describe 'POST /api/v1/subscriptions' do
    let (:valid_attributes) do
      {
        subscription: {
          title: "Monthly Tea Subscription",
          price: 15.99,
          status: "active",
          frequency: "monthly",
          customer_id: customer.id,
          tea_ids: [tea.id]
        }
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/subscriptions', params: valid_attributes }

      it 'creates a subscription' do
        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(:created)
        expect(json[:data]).to be_a(Hash)
        expect(json[:data]).to have_key(:id)
        expect(json[:data][:attributes][:title]).to eq('Monthly Tea Subscription')
        expect(json[:data][:attributes][:price]).to eq('15.99')
        expect(json[:data][:attributes][:status]).to eq('active')
        expect(json[:data][:attributes][:frequency]).to eq('monthly')
        expect(json[:data][:attributes][:customer_id]).to eq(customer.id)
        expect(json[:data][:attributes][:tea_ids]).to eq([tea.id])
      end
    end
  end

  describe 'PUT /api/v1/subscriptions/:id' do
    let(:subscription) { create(:subscription, customer: customer, status: 'active') }

    context 'when the subscription exists' do
      before { put "/api/v1/subscriptions/#{subscription.id}", params: { subscription: { status: 'cancelled' } } }

      it 'cancels the subscription' do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:ok)
        expect(json[:data][:attributes][:status]).to eq('cancelled')
      end
    end
  end
end