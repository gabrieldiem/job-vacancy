require 'spec_helper'

describe Favorite do
  describe 'valid' do
    it 'should be have user' do
      job_offer = JobOffer.new(title: 'a title', salary: 10)

      check_validation(:user, "User can't be blank") do
        described_class.new(job_offer:)
      end
    end
  end
end
