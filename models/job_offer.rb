class JobOffer
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :id, :user, :user_id, :title,
                :location, :description, :salary, :is_active,
                :updated_on, :created_on, :experience_required

  MINIMUM_SALARY = 0
  MINIMUM_EXPERIENCE = 0
  SALARY_CANT_BE_BLANK_MESSAGE = "can't be blank".freeze
  CANT_BE_NEGATIVE_MESSAGE = "can't be negative".freeze
  YEARS_MUST_BE_INTEGER_MESSAGE = 'Please enter the years as a number'.freeze
  EXPERIENCE_CANT_BE_BLANK_MESSAGE = "can't be blank".freeze

  validates :title, presence: true
  validate :is_salary_valid?
  validate :is_experience_valid?

  def initialize(data = {})
    @id = data[:id]
    @title = data[:title]
    @location = data[:location]
    @description = data[:description]
    @is_active = data[:is_active]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @user_id = data[:user_id]
    @salary = data[:salary]
    @experience_required = data[:experience_required]
    validate!
  end

  def owner
    user
  end

  def owner=(a_user)
    self.user = a_user
  end

  def activate(current_active_offers_for_user)
    user.subscription_has_allowance? current_active_offers_for_user
    self.is_active = true
  end

  def deactivate
    self.is_active = false
  end

  def old_offer?
    (Date.today - @updated_on) >= 30
  end

  def is_salary_specified?
    @salary > MINIMUM_SALARY
  end

  def is_experience_specified?
    @experience_required > MINIMUM_EXPERIENCE
  end

  def self.no_experience_required
    MINIMUM_EXPERIENCE
  end

  def self.unspecified_salary_number
    MINIMUM_SALARY
  end

  def self.unspecified_experience_number
    MINIMUM_EXPERIENCE
  end

  def is_active?
    @is_active
  end

  private

  def is_salary_valid?
    errors.add(:salary, SALARY_CANT_BE_BLANK_MESSAGE) if @salary.blank? || @salary.nil?

    errors.add(:salary, CANT_BE_NEGATIVE_MESSAGE) if @salary.to_i < MINIMUM_SALARY
  end

  def is_experience_valid?
    if @experience_required.blank? || @experience_required.nil?
      errors.add(:experience_required, EXPERIENCE_CANT_BE_BLANK_MESSAGE)
    elsif !@experience_required.to_s.match?(/\A[+-]?\d+\z/)
      errors.add(:experience_required, YEARS_MUST_BE_INTEGER_MESSAGE)
    elsif @experience_required.to_i < MINIMUM_EXPERIENCE
      errors.add(:experience_required, CANT_BE_NEGATIVE_MESSAGE)
    end
  end
end
