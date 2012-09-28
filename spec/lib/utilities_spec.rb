require 'feedisco'

describe "Feedisco::Utilities" do
  
  describe 'harmonize_url' do

    { 'example.com' => 'http://example.com',
      'example.com/page' => 'http://example.com/page',
      'feed://example.com' => 'http://example.com',
      'http://example.com' => 'http://example.com',
      'https://example.com' => 'https://example.com',
      'ftp://example.com' => nil
    }.each do |url, expected|

      it "should return '#{expected || :nil}' for '#{url}'" do
        Feedisco.harmonize_url(url).should == expected
      end
    end
  end

  describe 'complete_extracted_url' do

    it 'should return the extracted url if it is absolute' do
      Feedisco.complete_extracted_url('http://example.com/page', 'http://example.com/another').should == 'http://example.com/page'
    end

    it 'should add the scheme and host if the extracted url is relative from the root path' do
      Feedisco.complete_extracted_url('/page', 'http://example.com').should == 'http://example.com/page'
    end

    it 'should add the extracted_url\'s path if it\'s relative from the page\'s page' do
      Feedisco.complete_extracted_url('page', 'http://example.com/root').should == 'http://example.com/root/page'
    end

    it 'should raise ArgumentError if both extracted and page urls are relative' do
      expect {
        Feedisco.complete_extracted_url('/relative', '/relative/too')
      }.to raise_error(ArgumentError)
    end
  end
end
