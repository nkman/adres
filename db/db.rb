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
        @table = "local_data"

    end

    def connect
        @DB = Sequel.connect(
            :adapter=>'postgres', 
            :host=>@host, 
            :database=>@database, 
            :user=>@user, 
            :password=>@password
        )
        # puts @DB
        puts "Connected to database !"
    end

    def create_db
        @DB.create_table? @table do
            primary_key :id
            String :name, :size=>100
            String :label, :size=>200
            String :enr, :size=>100

            String :username_sds, :size=>30
            String :uid_sds, :size=>10
            String :course_sds, :size=>200
            String :sec_sds, :size=>10
            String :name_sds, :size=>100
            Integer :year_sds
        end
    end

    def populate_db(data)
        db = @DB[:local_data]
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

    def get_all_data()
        all_data = @DB.fetch("SELECT * FROM #{@table}")
        return all_data
    end

end

# """

# #{"username": "Aaditya", "uid": "3241", "course": "B.Tech", "sec": "1", "branch": "Mechanical Engineering", "year": "3", "name": "Aaditya Paliwal"}
# """