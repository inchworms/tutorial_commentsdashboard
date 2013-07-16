require 'nokogiri'

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
          item 
        end
      end
    end
  end
end


