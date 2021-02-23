class View
  attr_accessor :client, :content, :date

  def initialize(client, content, date)
    @client = client
    @content = content
    @date = date
  end
end
