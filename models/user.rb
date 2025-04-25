require_relative './subscriptions/subscription_factory'

class User
  include ActiveModel::Validations
  attr_accessor :id, :name, :email, :crypted_password, :updated_on, :created_on, :subscription, :birthdate

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i
  MIN_AGE = 18
  MAX_AGE = 150

  DATE_MUST_BE_PAST_MESSAGE = 'date must be in the past'.freeze
  OVER_18_MESSAGE = 'must be over 18 to register'.freeze
  BIRTHDATE_INVALID_MESSAGE = 'birth date invalid'.freeze

  validate :validate_birthdate_rules
  validates :name, :crypted_password, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX,
                                              message: 'invalid' }

  def initialize(data = {})
    assign_basic_attributes(data)
    assign_subscription(data)
    assign_password(data)
  end

  def has_password?(password)
    Crypto.decrypt(crypted_password) == password
  end

  def billed_amount(offers)
    @subscription.calculate_cost offers
  end

  def subscription_has_allowance?(active_offers)
    @subscription.has_allowance? active_offers
  end

  private

  def assign_basic_attributes(data)
    @id = data[:id]
    @name = data[:name]
    @email = data[:email]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @birthdate = data[:birthdate]
    @current_date = CurrentDateProvider.new(data[:current_date]).today
  end

  def assign_subscription(data)
    @subscription = SubscriptionFactory.new.create_subscription(data[:subscription_type], email)
  end

  def assign_password(data)
    @crypted_password = if data[:password].nil?
                          data[:crypted_password]
                        else
                          Crypto.encrypt(data[:password])
                        end
  end

  def calculate_age(birthdate, current_date)
    age = current_date.year - birthdate.year
    if (birthdate.month < current_date.month) ||
       (birthdate.month == current_date.month && birthdate.day < current_date.day)
      age -= 1
    end
    age
  end

  def validate_birthdate_rules
    return if @birthdate.nil?

    if @birthdate > @current_date
      errors.add(:birthdate, DATE_MUST_BE_PAST_MESSAGE)
      return
    end

    age = calculate_age(@birthdate, @current_date)
    errors.add(:birthdate, OVER_18_MESSAGE) if age < MIN_AGE
    errors.add(:birthdate, BIRTHDATE_INVALID_MESSAGE) if age > MAX_AGE
  end
end
