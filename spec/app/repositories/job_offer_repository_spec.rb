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

  def create_job_offer(title, salary, other_data = { is_active: true })
    JobOffer.new(title:, updated_on: today, user_id: owner.id, salary:, **other_data)
  end

  def save_and_retrieve_by_id(job_offer)
    repository.save(job_offer)
    repository.find(job_offer.id)
  end

  it 'A JobOffer with title "Dev", description "Remote" is saved and retrieved correctly' do
    job_offer = create_job_offer('Dev', 0, { description: 'Remote' })
    found_offer = save_and_retrieve_by_id(job_offer)
    expect(found_offer.title).to eq 'Dev'
    expect(found_offer.description).to eq 'Remote'
  end

  it 'A JobOffer with title "Dev" and location "USA" is saved and retrieved correctly' do
    job_offer = create_job_offer('Dev', 0, { location: 'USA' })
    found_offer = save_and_retrieve_by_id(job_offer)
    expect(found_offer.title).to eq 'Dev'
    expect(found_offer.location).to eq 'USA'
  end

  it 'A JobOffer with title "Dev" and is not active is saved and retrieved correctly' do
    job_offer = create_job_offer('Dev', 0, { is_active: false })
    found_offer = save_and_retrieve_by_id(job_offer)
    expect(found_offer.title).to eq 'Dev'
    expect(found_offer.is_active).to be false
  end

  it 'A JobOffer saved and retreived should have a salary of 10000 when created with it' do
    job_offer = create_job_offer('title', 10_000)

    found_offer = save_and_retrieve_by_id(job_offer)
    expect(found_offer.salary).to eq 10_000
  end

  describe 'deactive_old_offers' do
    def create_job_offer_with_update_date(title, salary, update_on)
      JobOffer.new(title:, updated_on: update_on, user_id: owner.id, salary:, is_active: true)
    end

    let!(:today_offer) do
      today_offer = create_job_offer_with_update_date('a title', 0, Date.today)
      repository.save(today_offer)
      today_offer
    end

    let!(:thirty_day_offer) do
      thirty_day_offer = create_job_offer_with_update_date('a title', 0, Date.today - 45)
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

    it 'A JobOffer with experience required 10 years is saved and retrieved correctly' do
      job_offer = create_job_offer('Dev', 0, { experience_required: 10 })
      found_offer = save_and_retrieve_by_id(job_offer)
      expect(found_offer.experience_required).to eq 10
    end
  end
end
