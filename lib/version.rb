class Version
  MAYOR = 0
  MINOR = 4
  PATCH = 14

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end
