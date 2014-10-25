require 'json'

class Configure

    def initialize
        cwd = File.expand_path File.dirname(__FILE__)
        @elastic_config = File.join(cwd, "elasticsearch.json")
        @psql = File.join(cwd, "config.json")
        @local = File.join(cwd, "db_local.json")
    end

    def return_data(ret)
        #0 --> Local
        #1 --> psql
        #2 --> elasticsearch
        to_ret = Integer(ret)

        case to_ret

        when 0
            return local
        when 1
            return psql
        when 2
            return elasticsearch
        end
    end

    def local
        local_json = File.read(@local)
        obj = JSON.parse(local_json)
        return obj
    end

    def psql
        psql_json = File.read(@psql)
        obj = JSON.parse(psql_json)
        return obj
    end

    def elasticsearch
        elasticsearch_json = File.read(@elastic_config)
        obj = JSON.parse(elasticsearch_json)
        return obj
    end

end
