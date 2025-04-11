class User
  include ActiveModel::Validations
  attr_accessor :id, :name, :email, :crypted_password, :updated_on, :created_on

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, :crypted_password, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX,
                                              message: 'invalid' }

  def initialize(data = {})
    @id = data[:id]
    @name = data[:name]
    @email = data[:email]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @subscription = SubscriptionFactory.new.create_subscription(data[:subscription_type], email)

    @crypted_password = if data[:password].nil?
                          data[:crypted_password]
                        else
                          Crypto.encrypt(data[:password])
                        end
  end

  def has_password?(password)
    Crypto.decrypt(crypted_password) == password
  end

  def billed_amount(offers)
    @subscription.calculate_cost offers
  end
end
