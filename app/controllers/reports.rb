JobVacancy::App.controllers :reports, provides: [:json] do
  get :billing do
    job_offer_repo = JobOfferRepository.new
    users_repo = UserRepository.new

    offer_counter = OfferCounter.new(job_offer_repo)
    all_users = users_repo.all
    total_amount = 0

    report = {
      items: [],
      total_active_offers: offer_counter.count_active,
      total_amount:
    }

    all_users.each do |user|
      offers = job_offer_repo.find_by_owner(user)
      amount_to_pay = user.billed_amount(offers)
      total_amount += amount_to_pay

      report[:items].push({
                            amount_to_pay:,
                            user_email: user.email
                          })
    end

    report[:total_amount] = total_amount

    return report.to_json
  end
end
