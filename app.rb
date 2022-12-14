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
    @albums = repo.all
    return erb(:all_albums)
  end
# This GET METHOD IS REWRITTEN BELOW TO CARRY OUT A DIFFERENT FUNCTION
  # get '/artists' do
  #   repo = ArtistRepository.new
  #   array = repo.all
  #   artists = []
  #   array.each do |artist|
  #       artists << artist.name
  #   end

  #   return artists.join(", ")
  # end

  post '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params['name']
    artist.genre = params['genre']
    repo.create(artist)
  end

  get '/album/:id' do
    id = params[:id]
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new    
    @album = repo.find(id)
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album_find)
  end

  get '/artists/:id' do
    id = params[:id]
    repo = ArtistRepository.new
    @artist = repo.find(id)
    return erb(:artist_page)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artists_page)
  end
end