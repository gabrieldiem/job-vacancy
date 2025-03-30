class JobOffer
  include ActiveModel::Validations

  attr_accessor :id, :user, :user_id, :title,
                :location, :description, :salary, :is_active,
                :updated_on, :created_on

  MINIMUM_SALARY = 0

  validates :title, presence: true
  validates :salary, presence: true, unless: lambda {
                                               salary.blank? || salary.nil? ? false : salary.to_i >= MINIMUM_SALARY
                                             }

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
end
