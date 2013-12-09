class Compliment
  attr_reader :message, :image

  def initialize(message, image)
    @message = message
    @image = image
  end
end