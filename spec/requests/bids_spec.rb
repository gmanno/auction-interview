require 'rails_helper'

RSpec.describe 'Bids', type: :request do
  let(:bid) { create(:bid) }
  let(:user) { create(:user, name: 'user2', email: 'test2@test.com') }
  let(:json) { JSON.parse(response.body) }
  let(:message) { json['message'] }

  before do
    bid
    user
  end

  describe 'GET /view' do
    it 'returns http success' do
      get '/view'
      expect(response).to have_http_status(:success)
      expect(json).to_not include('current_bid')
      expect(json).to include('highest_bid')
    end

    it 'returns http success' do
      get '/view/1'
      expect(response).to have_http_status(:success)
      expect(json).to include('current_bid', 'highest_bid')
    end
  end

  describe 'POST /bid' do
    it 'returns http success' do
      post '/bid', params: { user_id: 2, amount: 2}, as: :json
      expect(response).to have_http_status(:success)
      expect(message).to eq('Bid created successfully')
    end

    describe 'when the bid is not valid' do
      describe 'when the same user try to send a bid again' do
        it 'returns http unprocessable_entity' do
          post '/bid', params: { user_id: 1, amount: 2.2}, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe 'when sending a lower bid' do
        it 'returns http unprocessable_entity' do
          post '/bid', params: { user_id: 1, amount: 1.4}, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe 'when sending without the required params' do
        it 'returns http unprocessable_entity' do
          post '/bid'
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe 'when sending a invalid user' do
        it 'returns http not found' do
          post '/bid', params: { user_id: 4, amount: 2.2}, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
