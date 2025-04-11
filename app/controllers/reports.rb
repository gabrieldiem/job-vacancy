JobVacancy::App.controllers :reports, provides: [:json] do
  get :billing do
    repo = JobOfferRepository.new
    offer_counter = OfferCounter.new(repo)
    report = {
      items: [
        {
          "user_email": 'pepe@pepito.com',
          "amount_to_pay": 0.0
        }
      ],
      total_active_offers: offer_counter.count_active,
      total_amount: 0.0
    }
    return report.to_json
  end
end
