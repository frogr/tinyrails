require "multi_json"

module Tinyrails
  module Model
    class FileModel
      def initialize(filename)
        @filename = filename

        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i

        object = File.read(filename)
        @hash = MultiJson.load(object)
      end

      def [](author)
        @hash[author.to_s]
      end

      def []=(author, value)
        @hash[author.to_s] = value
      end

      def self.find(id)
        begin
          FileModel.new("db/quotes/#{id}.json")
        rescue
          return nil
        end
      end
    end
  end
end