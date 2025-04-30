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
    return false if session[:current_user].nil?

    user = UserRepository.new.find(session[:current_user])
    return false if user.nil?

    favorite = FavoriteRepository.new.find_by_user_and_job_offer(user, offer)
    !favorite.nil?
  end

  def is_same_owner?(offer)
    return false if session[:current_user].nil?

    user = UserRepository.new.find(session[:current_user])
    return false if user.nil?

    user.id == offer.user_id
  end
end
