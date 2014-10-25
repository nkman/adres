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
        body: { name: data[:name], enr: data[:enr] }

        @client.indices.refresh index: 'mordor'

    end

    def search()
        result = @client.search index: 'mordor', 
        type: 'rose',
        q: "12114042"
        puts result
        return result["hits"]["hits"][0]["_source"]["name"]
    end

end


"""
json = File.read('./../config/elasticsearch.json')
obj = JSON.parse(json)
index = Index.new(obj)
index.connect
index.index
"""