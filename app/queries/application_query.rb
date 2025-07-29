class ApplicationQuery
  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def self.call(*args)
    new(*args).call
  end
end
