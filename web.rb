require 'sinatra'
require 'json'

cwd = File.expand_path File.dirname(__FILE__)
db = File.join(cwd, "db", "db")
index = File.join(cwd, "index", "indexing")
config = File.join(cwd, "config", "init")

require_relative db
require_relative index
require_relative config

configure = Configure.new
elasticsearch_json = configure.return_data(2)
psql_json = configure.return_data(1)
local_json = configure.return_data(0)

indexer = Index.new(elasticsearch_json)
indexer.connect

DB = Database.new(local_json)
DB.connect

get '/' do
    return "Hello, world"
end

get '/index' do
    all_data = DB.get_all_data
    all_data.each do |item|
        indexer.index(item)
    end
    return "{\"Message\": \"Do that Manually !!\"}"
end

get '/insertion' do
    return "{\"Message\": \"Do that Manually !!\"}"
end

get '/search' do
    return indexer.search
end
