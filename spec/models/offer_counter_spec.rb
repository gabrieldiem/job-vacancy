require 'spec_helper'

describe OfferCounter do
  describe 'count_active' do
    it 'should be 0 when no active offers' do
      repo = instance_double('offer_repo', all_active: [])
      counter = described_class.new(repo)
      expect(counter.count_active).to eq 0
    end

    it 'count_active_by_user should be 1 when there is 1 active offers and 1 inactive' do
      offers = [
        JobOffer.new(title: 'a title', salary: 0, experience_required: 0, is_active: true),
        JobOffer.new(title: 'a title', salary: 0, experience_required: 0, is_active: false)
      ]
      repo = instance_double('offer_repo', find_by_owner: offers)
      counter = described_class.new(repo)
      expect(counter.count_active_by_user(User.new)).to eq 1
    end

    it 'count_active_offers should be 1 when there is 1 active offers and 1 inactive' do
      offers = [
        JobOffer.new(title: 'a title', salary: 0, experience_required: 0, is_active: true),
        JobOffer.new(title: 'a title', salary: 0, experience_required: 0, is_active: false)
      ]
      repo = instance_double('offer_repo', find_by_owner: offers)
      counter = described_class.new(repo)
      expect(counter.count_active_offers(offers)).to eq 1
    end
  end
end
