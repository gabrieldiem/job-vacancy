require 'spec_helper'

describe BirthdateParser do
  it 'A birthdate with valid format is valid' do
    date_string = '1995/10/10'
    birthdate = described_class.new(date_string).birthdate

    expect(birthdate).to eq(Date.new(1995, 10, 10))
  end
end
