require 'nokogiri'
require 'date'

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

      def parse xml
        doc = Nokogiri::XML xml
        doc.search('entry').map do |doc_item|
          item = {}
          item[:url] = doc_item.at('url').text
          item[:title] = doc_item.at('title').text
          item[:commenter] = doc_item.css('author name').text
          item[:date] = DateTime.parse doc_item.at('published').text
          item 
        end
      end
    end
  end
end


