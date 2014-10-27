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
        type: 'rose',
        body: { name: data[:name], enr: data[:enr], label: data[:label] }

        @client.indices.refresh index: 'mordor'

    end

    def search()
        result = @client.search index: 'mordor', 
        type: 'rose',
        q: "Abhishek"
        puts result
        return JSON.generate(result["hits"]["hits"])
    end

    def get_all_hits(query)
        result = @client.search index: 'mordor', 
        type: 'rose',
        q: query

        total_hits = result["hits"]["hits"]
        return total_hits
    end
end


"""
json = File.read('./../config/elasticsearch.json')
obj = JSON.parse(json)
index = Index.new(obj)
index.connect
index.index
"""