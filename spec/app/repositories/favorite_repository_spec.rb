require 'integration_spec_helper'

describe FavoriteRepository do
  let(:repository) { described_class.new }

  let(:owner) do
    owner = User.new(name: 'Jane', email: 'jane@doe.com', crypted_password: 'secure_pwd')
    UserRepository.new.save(owner)
    owner
  end

  it 'A Favorite associated with a user and a job offer is saved and retrieved correctly' do
    job_offer_repo = JobOfferRepository.new
    user_repo = UserRepository.new

    other_user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    user_repo.save(other_user)

    an_offer = JobOffer.new(title: 'a title', salary: 0, user_id: owner.id)
    job_offer_repo.save(an_offer)

    an_offer = job_offer_repo.find_by_owner(owner).first

    favorite = Favorite.new(user: other_user, job_offer: an_offer)
    repository.save(favorite)

    favorite_found = repository.find_by_user_and_job_offer(other_user, an_offer)

    expect(favorite_found.user.id).to eq favorite.user.id
    expect(favorite_found.job_offer.id).to eq favorite.job_offer.id
  end

  it 'Can delete a favorite in FavoriteRepository' do
    job_offer_repo = JobOfferRepository.new
    user_repo = UserRepository.new

    other_user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    user_repo.save(other_user)

    an_offer = JobOffer.new(title: 'a title', salary: 0, user_id: owner.id)
    job_offer_repo.save(an_offer)

    an_offer = job_offer_repo.find_by_owner(owner).first

    favorite = Favorite.new(user: other_user, job_offer: an_offer)
    repository.save(favorite)

    repository.delete(favorite)

    favorite_found = repository.find_by_user_and_job_offer(other_user, an_offer)

    expect(favorite_found).to eq nil
  end

  it 'When i delete a Job Offer then the favorite must be deleted' do
    job_offer_repo = JobOfferRepository.new
    user_repo = UserRepository.new

    other_user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    user_repo.save(other_user)

    an_offer = JobOffer.new(title: 'a title', salary: 0, user_id: owner.id)
    job_offer_repo.save(an_offer)
    an_offer = job_offer_repo.find_by_owner(owner).first

    favorite = Favorite.new(user: other_user, job_offer: an_offer)
    repository.save(favorite)

    job_offer_repo.delete(an_offer)

    favorite_found = repository.find_by_user_and_job_offer(other_user, an_offer)

    expect(favorite_found).to eq nil
  end

  it 'When i delete an user then the favorite must be deleted' do
    job_offer_repo = JobOfferRepository.new
    user_repo = UserRepository.new

    other_user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    user_repo.save(other_user)

    an_offer = JobOffer.new(title: 'a title', salary: 0, user_id: owner.id)
    job_offer_repo.save(an_offer)
    an_offer = job_offer_repo.find_by_owner(owner).first

    favorite = Favorite.new(user: other_user, job_offer: an_offer)
    repository.save(favorite)

    user_repo.delete(other_user)

    favorite_found = repository.find_by_user_and_job_offer(other_user, an_offer)

    expect(favorite_found).to eq nil
  end

  it 'Deletes all favorites of a user' do
    user_repo = UserRepository.new
    job_offer_repo = JobOfferRepository.new

    other_user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    user_repo.save(other_user)
    offers = [JobOffer.new(title: 'a title', salary: 0, user_id: owner.id),
              JobOffer.new(title: 'another title', salary: 0, user_id: owner.id)]
    offers.each do |offer|
      job_offer_repo.save(offer)
      favorite = Favorite.new(user: other_user, job_offer: offer)
      repository.save(favorite)
    end

    repository.delete_all_by_user(other_user)

    offers.each do |offer|
      expect(repository.find_by_user_and_job_offer(other_user, offer)).to eq nil
    end
  end
end
