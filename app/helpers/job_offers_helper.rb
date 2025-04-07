# Helper methods defined here can be accessed in any controller or view in the application

NOT_SPECIFIED_SALARY_MESSAGE = 'Not specified'.freeze

JobVacancy::App.helpers do
  def job_offer_params
    params[:job_offer_form].to_h.symbolize_keys
  end

  def print_salary(offer)
    offer.is_salary_specified? ? offer.salary : NOT_SPECIFIED_SALARY_MESSAGE
  end
end
