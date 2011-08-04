#webmock-disabler
webmock-disabler is a gem that allows users of [WebMock](https://github.com/bblimke/webmock) to disable and re-enable WebMock on-demand. This is useful in testing scenarios where the mere presence of WebMock causes some tests to fail. A common case is that the presence of WebMock is known to cause failures in Selenium-based integration tests, such as RSpec's request specs and Cucumber features.

The blog post introducing webmock-disabler is [here](https://pivotallabs.com/users/danny/blog/articles/1743-making-webmock-selenium-and-webdriver-play-nicely).

#Installation
    gem install webmock-disabler
or, if you use Bundler

    gem 'webmock-disabler'
    
#Requirements
webmock-disabler works by monkey patching WebMock, so, its implementation is understandably fragile.  It was written against version 1.6.4 of WebMock, and it might work with higher 1.x versions.  Then again, it might not.  

If future versions of WebMock break webmock-disabler, file an issue about it, or, better yet, fork, fix, and send a pull request.

#Limitations
While WebMock can mock out lots of different HTTP libraries (Net::HTTP, HTTPClient, EventMachine::HttpRequest, and more), webmock-disabler only supports Net::HTTP.  So if you're using any HTTP library other than Net::HTTP, don't expect webmock-disabler to do squat.

I have no plans to implement support for other HTTP libraries, but I do have plans to accept pull requests- so have at it.

#Usage
    require 'webmock'
    require 'webmock/disabler'

    Net::HTTP.get(URI.parse('http://www.google.com')) => raises WebMock::NetConnectNotAllowedError

    WebMock.disable!

    Net::HTTP.get(URI.parse('http://www.google.com')) => the HTML at www.google.com

    WebMock.enable!

    Net::HTTP.get(URI.parse('http://www.google.com')) => raises WebMock::NetConnectNotAllowedError
    
#Usage with RSpec
In your spec_helper.rb:

    before(:each), :type => :request do
      WebMock.disable!
    end

    after(:each), :type => :request do
      WebMock.enable!
    end

#Usage with Cucumber / Rails

You can create a tag to run a particular feature with WebMock disabled.

Create webmock_disabler.rb in your features/support directory:

    require 'webmock'
    require 'webmock/disabler'

    Before('@nowebmock') do
      WebMock.disable!
    end

    After('@nowebmock') do
      WebMock.enable!
    end

Then tag any feature where you want to disable WebMock with '@nowebmock'