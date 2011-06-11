module WebMock
  def self.enable!
    @@enabled = true
  end
  
  def self.disable!
    @@enabled = false
  end
  
  def self.enabled?
    @@enabled
  end
end

WebMock.enable!
