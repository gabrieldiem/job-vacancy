require_relative './subscriptions/subscription_factory'

class User
  include ActiveModel::Validations
  attr_accessor :id, :name, :email, :crypted_password, :updated_on, :created_on, :subscription

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i
  MIN_AGE = 18

  validate :validate_birthdate
  validates :name, :crypted_password, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX,
                                              message: 'invalid' }

  def initialize(data = {})
    data[:birthdate] = '2000/12/12' if data[:birthdate] == ''
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
    @birthdate = Date.strptime(data[:birthdate] || '2000/12/12', '%Y/%m/%d')
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

  def validate_birthdate
    return if @birthdate.nil?

    errors.add(:birthdate, 'date must be in the past') if @birthdate > @current_date

    age = ((@current_date - @birthdate).to_i / 365.25).floor
    errors.add(:birthdate, 'must be over 18 to register') if age < MIN_AGE
  end
end
