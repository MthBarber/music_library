# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end
  post '/albums' do
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)
  end

  get '/albums' do
    repo = AlbumRepository.new
    return repo.all
  end

  get '/artists' do
    repo = ArtistRepository.new
    array = repo.all
    artists = []
    array.each do |artist|
        artists << artist.name
    end

    return artists.join(", ")
  end

  post '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params['name']
    artist.genre = params['genre']
    repo.create(artist)
  end
end