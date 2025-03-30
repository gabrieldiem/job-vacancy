require 'spec_helper'

describe JobOffer do
  describe 'valid?' do
    it 'should be invalid when title is blank' do
      check_validation(:title, "Title can't be blank") do
        described_class.new(location: 'a location')
      end
    end

    it 'should be valid when title is not blank' do
      job_offer = described_class.new(title: 'a title')
      expect(job_offer).to be_valid
    end
  end

  it 'should have a salary of 10000 when created with it' do
    job_offer = described_class.new(title: 'a title', salary: 10_000)
    expect(job_offer.salary).to eq 10_000
  end
end
