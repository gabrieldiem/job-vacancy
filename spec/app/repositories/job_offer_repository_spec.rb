require 'integration_spec_helper'

describe JobOfferRepository do
  let(:repository) { described_class.new }

  let(:owner) do
    user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    UserRepository.new.save(user)
    user
  end

  let(:today) do
    Date.today
  end

  def save_and_retrieve_by_id(job_offer)
    repository.save(job_offer)
    repository.find(job_offer.id)
  end

  it 'A JobOffer with title "Dev", description "Remote" and is active is saved and retrieved correctly' do
    job_offer = JobOffer.new(title: 'Dev', description: 'Remote', updated_on: today, is_active: true, user_id: owner.id)
    found_offer = save_and_retrieve_by_id(job_offer)
    expect(found_offer.title).to eq 'Dev'
    expect(found_offer.description).to eq 'Remote'
    expect(found_offer.is_active).to be true
  end

  it 'A JobOffer with title "Dev" and location "USA" is saved and retrieved correctly' do
    job_offer = JobOffer.new(title: 'Dev', location: 'USA', updated_on: today, is_active: true, user_id: owner.id)
    found_offer = save_and_retrieve_by_id(job_offer)
    expect(found_offer.title).to eq 'Dev'
    expect(found_offer.location).to eq 'USA'
  end

  it 'A JobOffer with title "Dev" and is not active is saved and retrieved correctly' do
    job_offer = JobOffer.new(title: 'Dev', updated_on: today, is_active: false, user_id: owner.id)
    found_offer = save_and_retrieve_by_id(job_offer)
    expect(found_offer.title).to eq 'Dev'
    expect(found_offer.is_active).to be false
  end

  it 'A JobOffer saved and retreived should have a salary of 10000 when created with it' do
    job_offer = JobOffer.new(title: 'title', updated_on: today, salary: 10_000, is_active: true, user_id: owner.id)
    found_offer = save_and_retrieve_by_id(job_offer)
    expect(found_offer.salary).to eq 10_000
  end

  describe 'deactive_old_offers' do
    let!(:today_offer) do
      today_offer = JobOffer.new(title: 'a title',
                                 updated_on: Date.today,
                                 is_active: true,
                                 user_id: owner.id)
      repository.save(today_offer)
      today_offer
    end

    let!(:thirty_day_offer) do
      thirty_day_offer = JobOffer.new(title: 'a title',
                                      updated_on: Date.today - 45,
                                      is_active: true,
                                      user_id: owner.id)
      repository.save(thirty_day_offer)
      thirty_day_offer
    end

    it 'should deactivate offers updated 45 days ago' do
      repository.deactivate_old_offers

      updated_offer = repository.find(thirty_day_offer.id)
      expect(updated_offer.is_active).to eq false
    end

    it 'should not deactivate offers created today' do
      repository.deactivate_old_offers

      not_updated_offer = repository.find(today_offer.id)
      expect(not_updated_offer.is_active).to eq true
    end
  end
end
