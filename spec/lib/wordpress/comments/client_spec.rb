# coding: utf-8
require_relative '../../../../lib/wordpress/comments/client.rb'

describe Wordpress::Comments::Client do

  let(:client) { Wordpress::Comments::Client.new 'http://teams.railsgirlssummerofcode.org/activities.atom' }
  
  describe "#initialize" do

    it "stores a URL" do
      expect(client.url).to eq 'http://teams.railsgirlssummerofcode.org/activities.atom'
    end

  end

  describe "#parse" do
    # variablen definieren
    let(:xml) { File.read(File.join('spec', 'fixtures', 'feed.xml'))}
    let(:posts) { client.parse xml }
    let(:post) { posts.first }
    
    it "extracts the link" do
      url = 'http://defendingdiaspora.wordpress.com/?p=198'
      expect(post[:url]).to eq url 
    end

    it "extracts the title" do
      title = "Testing before coding !!"
      expect(post[:title]).to eq title
    end

  end

end