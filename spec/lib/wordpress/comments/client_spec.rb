# coding: utf-8
require_relative '../../../../lib/wordpress/comments/client'
require_relative '../../../support/match_date'

describe Wordpress::Comments::Client do

  let(:client) { Wordpress::Comments::Client.new 'http://teams.railsgirlssummerofcode.org/activities.atom' }
  let(:xml) { File.read(File.join('spec', 'fixtures', 'feed.xml'))}
  
  describe "#initialize" do

    it "stores a URL" do
      expect(client.url).to eq 'http://teams.railsgirlssummerofcode.org/activities.atom'
    end

  end

  describe "#parse" do
    # variablen definieren
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

    it "extracts the name of the commenter" do
      expect(post[:commenter]).to eq 'Team Diasbits! <3 (Rails app generator and Diaspora)'
    end

    it "extracts the date" do
      # 2013-07-16T05:34:27Z
      expect(post[:date].year).to eq 2013
    end

    it "extracts the date(redux)" do
      # 2013-07-16T05:34:27Z
      expect(post[:date]).to match_date '2013-07-16'
    end

  end

  describe "#fetch" do
  let(:posts) {client.fetch}

    context "success" do 

      before(:each) do
        client.stub(:get).and_return(xml)
      end

      it "build post objects" do
        expect(posts.length).to eq 50
      end

    end

    context "bad URL" do

      let(:client) { Wordpress::Comments::Client.new 'not a URL' }

      it "raises error" do
        expect {
          client.fetch
        }.to raise_error(Errno::ENOENT)
      end 

    end

    context "bad XML" do

      before(:each) do
        client.stub(:get).and_return("BAD XML!")
      end

      it "raise error from Nokogiri" do
        expect{
          client.fetch
          }.to raise_error(Nokogiri::XML::SyntaxError)
      end

    end

  end

end