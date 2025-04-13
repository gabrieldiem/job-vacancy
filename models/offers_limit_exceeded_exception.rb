class OffersLimitExceededException < StandardError
  def initialize(msg = 'Cannot activate more offers')
    super
  end
end
