class Page
  attr_reader :compliment, :permalink

  def initialize(compliment)
    @compliment = compliment
    @permalink = SecureRandom.hex
  end
end