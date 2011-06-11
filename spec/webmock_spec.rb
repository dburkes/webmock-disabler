require 'webmock/disabler'
require 'net/http'

describe WebMock do
  shared_examples_for "WebMock enabled" do
    it "does not allow outbound connections" do
      Net::HTTP.any_instance.should_not_receive(:request)
      lambda {
        Net::HTTP.get(URI.parse("http://www.google.com"))
      }.should raise_error(WebMock::NetConnectNotAllowedError)
    end
  end
  
  describe "default behavior" do
    it_should_behave_like "WebMock enabled"
  end
  
  describe ".disable!" do
    before(:each) do
      WebMock.disable!
    end
    
    after(:each) do
      WebMock.enable!
    end
    
    it "allows outbound connections" do
      Net::HTTP.any_instance.should_receive(:request).and_raise("good enough")
      lambda {
        Net::HTTP.get(URI.parse("http://www.google.com"))
      }.should raise_error("good enough")
    end
  end
  
  describe ".enable!" do
    before(:each) do
      WebMock.enable!
    end
    
    it_should_behave_like "WebMock enabled"
  end
end