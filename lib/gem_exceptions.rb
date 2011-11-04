class NewGemException < Exception
  def initialize(code, message)
    @code = code
    @message = message
  end
  
  attr_reader :code
  attr_reader :message
end

class NoFileProvidedGemException < NewGemException
  def initialize
    super(1, 'No file provided')
  end
end

class InvalidGemException < NewGemException
  def initialize
    super(2, 'Invalid gem has been provided')
  end
end

class AlreadyInstalledGemException < NewGemException
  def initialize
    super(3, 'This gem is already installed in the repository')
  end
end
