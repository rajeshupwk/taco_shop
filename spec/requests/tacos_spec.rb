require 'rails_helper'

RSpec.describe 'Tacos API', type: :request do
  # initialize test data 
  let!(:tacos) { create_list(:taco, 10) }
  let(:taco_id) { tacos.first.id }

  # Test suite for GET /api/v1/tacos
  describe 'GET /api/v1/tacos' do
    # make HTTP get request before each example
    before { get '/api/v1/tacos' }

    it 'returns tacos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/tacos/:id
  describe 'GET /api/v1/tacos/:id' do
    before { get "/api/v1/tacos/#{taco_id}" }

    context 'when the record exists' do
      it 'returns the taco' do
        #expect(json).to be_nil
        expect(json['id']).to eq(taco_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:taco_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Taco/)
      end
    end
  end

  # Test suite for POST /api/v1/tacos
  describe 'POST /api/v1/tacos' do
    # valid payload
    let(:valid_attributes) { { meat: 0 } }

    context 'when the request is valid' do
      before { post '/api/v1/tacos', params: valid_attributes }

      it 'creates a taco' do
        expect(json['meat']).to eq('chicken')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/tacos', params: { meat: 'Foo' } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"error\":\"meat is invalid\"}")
      end
    end
  end

  # Test suite for DELETE /api/v1/tacos/:id
  describe 'DELETE /api/v1/tacos/:id' do
    before { delete "/api/v1/tacos/#{taco_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end