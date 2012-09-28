require 'feedisco'

describe "Feedisco::Checks" do
  
  describe 'looks_like_feed?' do

    %w(feed.rdf feed.xml feed.rss feed?feed=atom feed?feed=rss feed/atom feed/feed feed/atom/ feed/feed/).each do |url|
      it "should return true for '#{url}' " do
        Feedisco.looks_like_feed?(url).should be_true
      end
    end

    %w(feed.txt feed?feed=atomic feed=none example.com/atomic).each do |url|
      it "should return false for '#{url}' " do
        Feedisco.looks_like_feed?(url).should_not be_true
      end
    end
  end

  describe 'feed? (using real websites, may break if they change)' do

    ['http://feeds.rchampourlier.com/rchampourlier',
     'http://rss.cnn.com/rss/cnn_topstories.rss'].each do |url|
      it "should return true for '#{url}'" do
        Feedisco.feed?(url).should be_true
      end
    end

    ['http://rchampourlier.com',
     'http://www.cnn.com/services/rss/'].each do |url|
      it "should return false for '#{url}'" do
        Feedisco.feed?(url).should_not be_true
      end
    end
  end
end
