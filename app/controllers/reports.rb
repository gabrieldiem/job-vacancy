SUBSCRIPTIONS_TYPES = {
  0 => 'on-demand'.freeze,
  1 => 'organizational'.freeze
}.freeze

JobVacancy::App.controllers :reports, provides: [:json] do
  get :billing do
    job_offer_repo = JobOfferRepository.new
    users_repo = UserRepository.new
    offer_counter = OfferCounter.new(job_offer_repo)

    all_users = users_repo.all
    total_amount = 0

    report = {
      items: [],
      total_active_offers: offer_counter.count_active
    }

    all_users.each do |user|
      offers = job_offer_repo.find_by_owner(user)
      amount_to_pay = user.billed_amount(offers)
      total_amount += amount_to_pay

      report[:items].push({
                            user_email: user.email,
                            subscription: SUBSCRIPTIONS_TYPES[user.subscription.id],
                            active_offers_count: offer_counter.count_active_offers(offers),
                            amount_to_pay: amount_to_pay.to_f
                          })
    end
    report[:total_amount] = total_amount.to_f
    return report.to_json
  end
end
