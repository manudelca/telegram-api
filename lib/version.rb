class Version
  MAYOR = 0
  MINOR = 11
  PATCH = 9

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end
