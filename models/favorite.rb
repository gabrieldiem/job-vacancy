class Favorite
  include ActiveModel::Validations

  attr_accessor :user, :job_offer, :id, :updated_on, :created_on

  validates :user, presence: true
  validates :job_offer, presence: true

  def initialize(data = {})
    @id = data[:id]
    @user = data[:user]
    @job_offer = data[:job_offer]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    validate!
  end
end
