class Favorite
  include ActiveModel::Validations

  attr_accessor :user, :job_offer, :id, :updated_on, :created_on, :user_id, :job_offer_id

  validate :is_user_valid?
  validate :is_job_offer_valid?
  validate :user_cannot_be_job_offer_owner

  def initialize(data = {})
    @id = data[:id]
    @user_id = data[:user_id]
    @user = data[:user]
    @job_offer_id = data[:job_offer_id]
    @job_offer = data[:job_offer]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    validate!
  end

  private

  def is_user_valid?
    errors.add(:user, "can't be blank") if user.nil? && user_id.nil?
  end

  def is_job_offer_valid?
    errors.add(:job_offer, "can't be blank") if job_offer.nil? && job_offer_id.nil?
  end

  def user_cannot_be_job_offer_owner
    return if user.nil? || job_offer.nil?

    errors.add(:user, "can't be the same as job offer owner") if user.id == job_offer.user_id
  end
end
