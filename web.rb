require 'sinatra'
require 'json'

cwd = File.expand_path File.dirname(__FILE__)
db = File.join(cwd, "db", "db")
index = File.join(cwd, "index", "indexing")
config = File.join(cwd, "config", "init")

require_relative db
require_relative index
require_relative config

get '/' do
    "Hello, world"
end

get '/data/insertion' do
    "LOL"
end