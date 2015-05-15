require 'sequel'
require 'json'

cwd = File.expand_path File.dirname(__FILE__)
db = File.join(cwd, "db", "db")
config = File.join(cwd, "config", "init")
index = File.join(cwd, "index", "indexing")

require_relative db
require_relative config
require_relative index

configure = Configure.new
local_json = configure.return_data(0)
elasticsearch_json = configure.return_data(2)

DB = Database.new(local_json)
DB.connect

indexer = Index.new(elasticsearch_json)
indexer.connect

DB.create_db
data = File.read('./data/modify.json')

data = JSON.parse(data)
DB.populate_db(data)


all_data = DB.get_all_data
all_data.each do |item|
    indexer.index(item)
end
