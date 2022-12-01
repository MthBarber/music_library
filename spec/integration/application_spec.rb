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
    xit 'should create a new album' do
      # Assuming the post with id 1 exists.
      response = post('/albums',title: 'Voyage',release_year: '2022', artist_id:'2')

      expect(response.status).to eq(200)
      get_response = get('/albums')
      expect(get_response.body).to include('Voyage')
    end
  end

  # context "GET /artists" do
  #   it 'returns 200 OK' do
      
  #     response = get('/artists')

  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos")
  #   end

  #   it 'returns 404 Not Found' do
  #     response = get('/artist?title=276278')

  #     expect(response.status).to eq(404)
  #     # expect(response.body).to eq(expected_response)
  #   end
  # end

  # context "POST /artists" do
  #   it 'returns 200 OK' do
  #     # Assuming the post with id 1 exists.
  #     response = post('/artists?name=Wild nothing&genre=Indie')
  #     check_post = get('/artists')
  #     expect(response.status).to eq(200)
  #     expect(check_post.body).to include("Wild nothing")
  #   end

    
  # end

  context "GET /album/:id " do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/album/3')

      expect(response.status).to eq(200)
      
    end

    it 'Returns the album with an ID of 1' do
      # Assuming the album with id 1 exists.
      response = get('/album/3')      
      expect(response.body).to include('<h1> Waterloo </h1>')
      expect(response.body).to include('1974')
      expect(response.body).to include('ABBA')
    end

    it 'Returns the album with an ID of 2' do
      # Assuming the post with id 2 exists.
      response = get('/album/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1> Surfer Rosa </h1>')
      expect(response.body).to include('1988')
      expect(response.body).to include('Pixies')
    end

        
  end

  context "GET /artists/:id" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1> Pixies </h1>')
    end

    
  end

  context "GET /artists" do
    it 'returns 200 OK and returns a list of artists' do
      # Assuming the post with id 1 exists.
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include('<a href=/artists/2> ABBA </a>')
    end

   
  end
end
