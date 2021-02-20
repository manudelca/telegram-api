require 'spec_helper'

describe EmailValidator do
  let(:email_validator) { described_class.new }

  it 'test@test.com should be valid' do
    email = 'test@test.com'

    expect(email_validator.validate(email)).to eq(email)
  end

  it 'test@test should be invalid' do
    email = 'test@test'

    expect { email_validator.validate(email) }.to raise_error(InvalidEmailError)
  end

  it 'test.com should be invalid' do
    email = 'test.com'

    expect { email_validator.validate(email) }.to raise_error(InvalidEmailError)
  end

  it '@test.com should be invalid' do
    email = '@test.com'

    expect { email_validator.validate(email) }.to raise_error(InvalidEmailError)
  end
end
