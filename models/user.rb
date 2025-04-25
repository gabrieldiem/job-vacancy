require_relative './subscriptions/subscription_factory'

class User
  include ActiveModel::Validations
  attr_accessor :id, :name, :email, :crypted_password, :updated_on, :created_on, :subscription, :birthdate

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i
  MIN_AGE = 18
  MAX_AGE = 150

  validate :validate_birthdate_format
  validate :validate_birthdate_rules
  validates :name, :crypted_password, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX,
                                              message: 'invalid' }

  def initialize(data = {})
    assign_basic_attributes(data, data[:current_date] || Date.today)
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

  def assign_basic_attributes(data, current_date = Date.today)
    @id = data[:id]
    @name = data[:name]
    @email = data[:email]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @birthdate = data[:birthdate]
    @current_date = current_date
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

  def validate_birthdate_format
    return if @birthdate.nil?
    return errors.add(:birthdate, 'can\'t be blank') if @birthdate == ''

    begin
      @birthdate = Date.strptime(@birthdate, '%Y/%m/%d')
    rescue Date::Error
      errors.add(:birthdate, 'invalid date format')
      @birthdate = nil
      nil
    end
  end

  def validate_birthdate_rules
    return if @birthdate.nil? || @birthdate == ''

    errors.add(:birthdate, 'date must be in the past') if @birthdate > @current_date

    age = ((@current_date - @birthdate).to_i / 365.25).floor
    errors.add(:birthdate, 'must be over 18 to register') if age < MIN_AGE
    errors.add(:birthdate, 'birth date invalid') if age > MAX_AGE
  end
end
