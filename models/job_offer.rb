class JobOffer
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :id, :user, :user_id, :title,
                :location, :description, :salary, :is_active,
                :updated_on, :created_on

  MINIMUM_SALARY = 0
  SALARY_CANT_BE_BLANK_MESSAGE = "can't be blank".freeze
  SALARY_CANT_BE_NEGATIVE_MESSAGE = "can't be negative".freeze
  INPUT_FOR_UNSPECIFIED_SALARY_MESSAGE = "Input '#{MINIMUM_SALARY}' (without the ticks) for an unspecified salary".freeze

  validates :title, presence: true
  validate :is_salary_valid?

  after_validation :parse_input_salary

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
    validate!
  end

  def owner
    user
  end

  def owner=(a_user)
    self.user = a_user
  end

  def activate
    self.is_active = true
  end

  def deactivate
    self.is_active = false
  end

  def old_offer?
    (Date.today - updated_on) >= 30
  end

  def is_salary_specified?
    @salary > MINIMUM_SALARY
  end

  def unspecified_salary_number
    MINIMUM_SALARY
  end

  private

  def is_salary_valid?
    if @salary.blank? || @salary.nil?
      message = "#{SALARY_CANT_BE_BLANK_MESSAGE}. #{INPUT_FOR_UNSPECIFIED_SALARY_MESSAGE}"
      errors.add(:salary, message)
    end

    if @salary.to_i < MINIMUM_SALARY
      message = "#{SALARY_CANT_BE_NEGATIVE_MESSAGE}. #{INPUT_FOR_UNSPECIFIED_SALARY_MESSAGE}"
      errors.add(:salary, message)
    end
  end

  def parse_input_salary
    @salary = @salary.to_i
  end
end
