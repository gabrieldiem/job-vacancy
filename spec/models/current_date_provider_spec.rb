require 'spec_helper'

describe CurrentDateProvider do
  it 'Today is the day passed as current date' do
    date = Date.new(1995, 10, 10)

    expect(described_class.new(date).today).to eq(date)
  end

  it 'Today is today (Groundhog Day)' do
    date = Date.today

    expect(described_class.new(date).today).to eq(date)
  end
end
