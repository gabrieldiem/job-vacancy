require 'integration_spec_helper'

describe FavoriteRepository do
  let(:repository) { described_class.new }

  let(:owner) do
    user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    UserRepository.new.save(user)
    user
  end

  it 'A Favorite associated with a user and a job offer is saved and retrieved correctly' do
    job_offer_repo = JobOfferRepository.new

    an_offer = JobOffer.new(title: 'a title', salary: 0, user_id: owner.id)
    job_offer_repo.save(an_offer)
    an_offer = job_offer_repo.find_by_owner(owner).first

    favorite = Favorite.new(user: owner, job_offer: an_offer)
    repository.save(favorite)

    favorite_found = repository.find_by_user_and_job_offer(owner, an_offer)

    expect(favorite_found.user.id).to eq favorite.user.id
    expect(favorite_found.job_offer.id).to eq favorite.job_offer.id
  end

  it 'Can delete a favorite in FavoriteRepository' do
    job_offer_repo = JobOfferRepository.new

    an_offer = JobOffer.new(title: 'a title', salary: 0, user_id: owner.id)
    job_offer_repo.save(an_offer)
    an_offer = job_offer_repo.find_by_owner(owner).first

    favorite = Favorite.new(user: owner, job_offer: an_offer)
    repository.save(favorite)

    repository.delete(favorite)

    favorite_found = repository.find_by_user_and_job_offer(owner, an_offer)

    expect(favorite_found).to eq nil
  end

  it 'When i delete a Job Offer then the favorite must be deleted' do
    job_offer_repo = JobOfferRepository.new

    an_offer = JobOffer.new(title: 'a title', salary: 0, user_id: owner.id)
    job_offer_repo.save(an_offer)
    an_offer = job_offer_repo.find_by_owner(owner).first

    favorite = Favorite.new(user: owner, job_offer: an_offer)
    repository.save(favorite)

    job_offer_repo.delete(an_offer)

    favorite_found = repository.find_by_user_and_job_offer(owner, an_offer)

    expect(favorite_found).to eq nil
  end
end
