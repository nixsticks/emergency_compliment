class Page
  attr_reader :compliment, :permalink

  def initialize(compliment)
    @compliment = compliment
    compliments = YAML::load(File.open("permalinks.yaml"))
    match = compliments.detect {|element| element.message == @compliment.message && element.image == @compliment.image}
    match ? @permalink = match.permalink : @permalink = SecureRandom.hex
  end
end