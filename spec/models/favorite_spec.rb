require 'spec_helper'

describe Favorite do
  describe 'valid' do
    it 'the user should not be blank' do
      job_offer = JobOffer.new(title: 'a title', salary: 10, user_id: 128)

      check_validation(:user, "User can't be blank") do
        described_class.new(job_offer:)
      end
    end

    it 'the job offer should not be blank' do
      user = User.new(name: 'John Doe', email: 'john@doe.com',
                      crypted_password: 'a_secure_passWord!',
                      birthdate: Date.new(2000, 10, 8), current_date: Date.new(2021, 10, 8))

      check_validation(:job_offer, "Job offer can't be blank") do
        described_class.new(user:)
      end
    end

    it 'the favorite should be valid' do
      user = User.new(name: 'John Doe', email: 'john@doe.com',
                      crypted_password: 'a_secure_passWord!',
                      birthdate: Date.new(2000, 10, 8), current_date: Date.new(2021, 10, 8), id: 99)

      job_offer = JobOffer.new(title: 'a title', salary: 10, user_id: 128)
      favorite = described_class.new(user:, job_offer:)
      expect(favorite).to be_valid
    end

    it 'the favorite should be invalid if the user is the same a job offer owner' do
      user = User.new(name: 'John Doe', email: 'john@doe.com',
                      crypted_password: 'a_secure_passWord!',
                      birthdate: Date.new(2000, 10, 8), current_date: Date.new(2021, 10, 8), id: 99)

      job_offer = JobOffer.new(title: 'a title', salary: 10, user_id: 99)
      check_validation(:user, "User can't be the same as the job offer owner") do
        described_class.new(user:, job_offer:)
      end
    end
  end
end
