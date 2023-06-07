require 'rails_helper'

RSpec.describe 'Customers Subscriptions API', type: :request do
  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }

  let!(:tea1) { create(:tea) }
  let!(:tea2) { create(:tea) }  

  let!(:subscription1) { create(:subscription, customer: customer1, teas: [tea1, tea2]) }
  let!(:subscription2) { create(:subscription, customer: customer1, teas: [tea1]) }
  let!(:subscription3) { create(:subscription, customer: customer2, teas: [tea2]) }

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