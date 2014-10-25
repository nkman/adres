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

    def create_db
        @DB.create_table? :data_container do
            primary_key :id
            String :name, :size=>100
            String :label, :size=>200
            String :enr, :size=>100
        end
    end

    def populate_db(data)
        db = @DB[:data_container]
        data.each do |item|

            _label = item["label"]
            _label.sub! item["value"], ''
            _label.sub! '(', ''
            _label.sub! ')', ''

            _enr = item["id"]
            _enr.sub! ':', ''
            _enr.sub! item["value"], ''

            puts "Inserting #{item}"
            db.insert(
                :name => item["value"], 
                :label => _label, 
                :enr => _enr
            )
        end
    end

end

"""
json = File.read('./../config/config.json')
obj = JSON.parse(json)
db = Database.new(obj)
db.connect
db.create_db

data = File.read('./../data/modify.json')
data = JSON.parse(data)
db.populate_db(data)
"""