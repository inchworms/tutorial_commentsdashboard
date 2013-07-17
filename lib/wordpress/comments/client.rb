require 'nokogiri'
require 'date'
require 'open-uri'

module Wordpress
  module Comments
    class Client

      attr_reader :url
      # def url 
      #   @url
      # end

      def initialize url
        @url = url
      end

      def fetch
        xml = get @url
        parse xml
      end
      
      def parse xml
        doc = Nokogiri::XML(xml) { |config| config.strict }
        doc.search('entry').map do |doc_item|
          item = {}
          item[:url] = doc_item.at('url').text
          item[:title] = doc_item.at('title').text
          item[:commenter] = doc_item.css('author name').text
          item[:date] = DateTime.parse doc_item.at('published').text
          item 
        end
      end

      private

      def get url
        open url
      end
    end
  end
end


