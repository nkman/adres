require 'elasticsearch'
require 'json'

class Index

    def initialize(config)

        @host = config["host"]
        @user = config["user"]
        @password = config["password"]

    end

    def connect

        @client = Elasticsearch::Client.new log: true

    end

    def index(data)
        @client.cluster.health

        @client.index index: 'mordor', 
        type: 'rose', id: 1, 
        body: { name: data["value"], enr: data["id"] }

        @client.indices.refresh index: 'mordor'

        # @client.search index: 'mordor', body: { query: { match: { title: 'test' } } }
    end

end


"""
json = File.read('./../config/elasticsearch.json')
obj = JSON.parse(json)
index = Index.new(obj)
index.connect
index.index
"""