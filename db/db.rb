require 'rubygems'
require 'sequel'
require 'json'

class Database

    def initialize(config)
        @host = config["host"]
        @user = config["user"]
        @password = config["password"]
        @port = config["port"]
        @database = config["database"]

    end

    def connect
        @DB = Sequel.connect(
            :adapter=>'postgres', 
            :host=>@host, 
            :database=>@database, 
            :user=>@user, 
            :password=>@password
        )
        puts @DB
        puts "COnnected"
    end
end
	
json = File.read('./../config/config.json')
obj = JSON.parse(json)
db = Database.new(obj)
db.connect()
