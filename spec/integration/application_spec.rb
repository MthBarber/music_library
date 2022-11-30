require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "POST /albums" do
    it 'should create a new album' do
      # Assuming the post with id 1 exists.
      response = post('/albums',title: 'Voyage',release_year: '2022', artist_id:'2')

      expect(response.status).to eq(200)
      get_response = get('/albums')
      expect(get_response.body).to include('Voyage')
    end
  end

  context "GET /artists" do
    it 'returns 200 OK' do
      
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos")
    end

    it 'returns 404 Not Found' do
      response = get('/artist?title=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end

  context "POST /artists" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = post('/artists?name=Wild nothing&genre=Indie')
      check_post = get('/artists')
      expect(response.status).to eq(200)
      expect(check_post.body).to include("Wild nothing")
    end

    
  end
end