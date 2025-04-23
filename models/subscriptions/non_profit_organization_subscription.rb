require_relative './subscription_types_consts'

class NonProfitOrganizationSubscription
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  FREE_COST = 0.0
  ORG_TLD = '.org'.freeze
  OFFERS_LIMIT = 7

  attr_reader :id

  validate :is_email_valid?
  INVALID_EMAIL_MESSAGE = 'must have .org mail for non commercial organization subscription'.freeze

  def initialize(email)
    @id = SUBSCRIPTION_TYPE_NON_PROFIT_ORGANIZATION
    @email = email
    validate!
  end

  def has_allowance?(active_offers)
    raise OffersLimitExceededException if active_offers >= OFFERS_LIMIT

    active_offers < OFFERS_LIMIT
  end

  def calculate_cost(_offers)
    FREE_COST
  end

  def is_email_valid?
    errors.add(:email, INVALID_EMAIL_MESSAGE) unless @email.end_with?(ORG_TLD)
  end
end
