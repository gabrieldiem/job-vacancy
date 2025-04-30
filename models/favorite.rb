class Favorite
  include ActiveModel::Validations

  attr_accessor :user, :job_offer

  validates :user, presence: true

  def initialize(data = {})
    @user = data[:user]
    @job_offer = data[:job_offer]
    validate!
  end
end
