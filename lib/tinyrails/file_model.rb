require "multi_json"

module Tinyrails
  module Model
    class FileModel

      attr_accessor :data, :filename, :id
      def initialize(filename)
        @filename = filename

        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i

        obj = File.read(filename)
        @data = MultiJson.load(obj)
      end

      def [](name)
        @data[name.to_s]
      end

      def []=(name, value)
        @data[name.to_s] = value
      end

      def self.find(id)
        begin
          FileModel.new("app/db/tweets/#{id}.json")
        rescue
          return nil
        end
      end

      def self.all
        files = Dir["app/db/tweets/*.json"]
        files.map { |f| FileModel.new f }
      end

      def self.where(attributes={})
        return self.all if attributes.empty?

        self.all.select do |model|
          attributes.all? do |k, v|
            model[k] == v
          end
        end
      end

      def save
        File.write(@filename, MultiJson.dump(@data))
      end

      def update(new_hash)
        @data = @data.merge!(new_hash)
        self.save
      end
    end
  end
end