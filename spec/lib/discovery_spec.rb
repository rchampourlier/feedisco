require 'feedisco'

describe "Feedisco::Discovery" do
  
  describe "find" do
  
    it 'should raise an ArgumentError if specified url is nil' do
      expect {
        Feedisco.find(nil)
      }.to raise_error(ArgumentError)
    end

    it 'should return an array with only the specified URL if it has a feed content type' do
      file = stub(:class => stub(:to_s => 'Tempfile'), :content_type => 'application/xml')

      Feedisco.should_receive(:open).and_yield(file)
      Feedisco.find('example.com/feed.xml').should == ['http://example.com/feed.xml']
    end

    context 'from fixtures' do

      def file_for_fixture(fixture_file_name)
        file = File.open(File.join(File.dirname(__FILE__), '..', 'fixtures', fixture_file_name))
        file.stub!(:class => stub(:to_s => 'Tempfile'), :content_type => 'text/html')
        file
      end

      it 'should return an empty array' do
        Feedisco.should_receive(:open).and_yield(file_for_fixture 'no_link.html')
        Feedisco.find('example.com').should == []
      end

      it 'should include the alternate link' do
        file = file_for_fixture 'alternate.html'
        file.stub!(:class => stub(:to_s => 'Tempfile'), :content_type => 'text/html')

        Feedisco.should_receive(:open).and_yield(file)
        Feedisco.find('example.com').should include('http://example.com/feed.xml')
      end

      it 'should include a <a> link in the body' do
        file = file_for_fixture 'one_link_in_body.html'

        Feedisco.should_receive(:open).and_yield(file)
        Feedisco.find('example.com').should include("http://example.com/feed.rss")
      end

      it 'should include link to feeds on the URL\'s domain' do
        file = file_for_fixture 'several_links.html'

        Feedisco.should_receive(:open).and_yield(file)
        Feedisco.find('example.com').should include("http://example.com/feed.rss")
      end

      it 'should have the alternate link as the first of the returned feed' do
        file = file_for_fixture 'several_links.html'

        Feedisco.should_receive(:open).and_yield(file)
        Feedisco.find('example.com').first.should == "http://example.com/feed.xml"
      end

      it 'should include link to feeds on other domains' do
        file = file_for_fixture 'several_links.html'

        Feedisco.should_receive(:open).and_yield(file)
        Feedisco.find('example.com').should include "http://another.domain.com/feed.rss"
      end

      it 'should have links to feeds on other domains after links to feeds on the same domain' do
        file = file_for_fixture 'several_links.html'

        Feedisco.should_receive(:open).and_yield(file)
        feeds = Feedisco.find('example.com')
        feeds.index('http://example.com/feed.rss').should < feeds.index('http://another.domain.com/feed.rss')
      end

      it 'should include each link only once' do
        file = file_for_fixture 'several_links.html'

        Feedisco.should_receive(:open).and_yield(file)
        feeds = Feedisco.find('example.com')
        feeds.select { |f| f == 'http://example.com/feed.rss' }.count.should == 1
      end

      it "should complete a relative link" do
        Feedisco.should_receive(:open).and_yield(file_for_fixture 'several_links.html')
        feeds = Feedisco.find('example.com')
        feeds.should include 'http://example.com/feed.rss'
      end
    end

    context 'from real websites (this may change so some examples may break)' do

      it "should return the URL for a feed URL" do
        Feedisco.find('http://feeds.rchampourlier.com/rchampourlier').should == ['http://feeds.rchampourlier.com/rchampourlier']
      end

      it "should return an empty array for 'www.google.com'" do
        Feedisco.find("www.google.com").should == []
      end
    
      it "should return 'http://feeds.rchampourlier.com/rchampourlier' for 'rchampourlier.com'" do
        Feedisco.find("www.rchampourlier.com").should == ['http://feeds.rchampourlier.com/rchampourlier']
      end
    
      it "should raise an URI::InvalidURIError for an invalid URL" do
        expect {
          Feedisco.find("not url")
        }.to raise_error(URI::InvalidURIError)
      end
    
      it "should raise an ArgumentError if the specified url's scheme is not 'http(s)' or 'feed'" do
        expect {
          Feedisco.find('ftp://rchampourlier.com')
        }.to raise_error(ArgumentError)
      end
    end
  end
  
end
