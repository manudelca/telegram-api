class EmailValidator
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze

  def validate(email)
    validate_email_presence(email)
    validate_email_pattern(email, URI::MailTo::EMAIL_REGEXP)
    validate_email_pattern(email, VALID_EMAIL_REGEX)
    email
  end

  def validate_email_presence(email)
    raise NoEmailError if email.nil?
  end

  def validate_email_pattern(email, regex)
    raise InvalidEmailError if (email =~ regex).nil?
  end
end
