class OfferCounter
  def initialize(offer_repo)
    @repo = offer_repo
  end

  def count_active
    @repo.all_active.size
  end

  def count_active_by_user(user_id)
    offers = @repo.find_by_owner(user_id)
    count_active_offers(offers)
  end

  def count_active_offers(offers)
    count = 0
    offers.each do |offer|
      count += 1 if offer.is_active?
    end
    count
  end
end
