module Net  #:nodoc: all
  class BufferedIO
    def initialize_with_disabling(*args)
      WebMock.enabled? ? initialize_with_webmock(*args) : initialize_without_webmock(*args)
    end
    
    alias_method :initialize, :initialize_with_disabling
  end
  
  class HTTP
    class << self
      def socket_type_with_disabling
        WebMock.enabled? ? socket_type_with_webmock : socket_type_without_webmock
      end
      
      alias_method :socket_type, :socket_type_with_disabling
    end
    
    def request_with_disabling(*args, &block)
      WebMock.enabled? ? request_with_webmock(*args, &block) : request_without_webmock(*args, &block)
    end
    
    alias_method :request, :request_with_disabling
    
    def connect_with_disabling
      WebMock.enabled? ? connect_with_webmock : connect_without_webmock
    end
    
    alias_method :connect, :connect_with_disabling
  end
end