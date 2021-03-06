class View
  attr_accessor :client, :content, :date

  def initialize(client, content, date)
    raise ContentNotReleasedError unless content.was_released?(date)

    @client = client
    @content = content
    @date = date
  end
end
