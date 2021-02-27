class Version
  MAYOR = 0
  MINOR = 7
  PATCH = 5

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end
