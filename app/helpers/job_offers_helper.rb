# Helper methods defined here can be accessed in any controller or view in the application

NOT_SPECIFIED_SALARY_MESSAGE = 'Not specified'.freeze

JobVacancy::App.helpers do
  def job_offer_params
    params[:job_offer_form].to_h.symbolize_keys
  end

  def print_salary(offer)
    offer.is_salary_specified? ? offer.salary : NOT_SPECIFIED_SALARY_MESSAGE
  end

  def is_favorite?(offer)
    return false unless @current_user

    return false unless current_user

    favorite = FavoriteRepository.new.find_by_user_and_job_offer(current_user, offer)
    !favorite.nil?
  end
end
