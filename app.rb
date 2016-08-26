require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'

DataMapper::setup(
  :default,
  "sqlite3://#{Dir.pwd}/jokes.db"
)

class Comedian
  include DataMapper::Resource
  
  property(:id, Serial)
  property(:name, String)
  
  has(n, :jokes)
end

class Joke
  include DataMapper::Resource
  
  property(:id, Serial)
  property(:words, Text)
  
  belongs_to(:comedian)
end

DataMapper.finalize.auto_upgrade!

class JokeApp < Sinatra::Application
  
  get '/' do
    @jokes = Joke.all
    erb :index
  end
  
  get '/random' do
    @joke = Joke.all.sample
    erb :random
  end
  
end