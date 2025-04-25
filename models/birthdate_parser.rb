require 'date'

class BirthdateParser
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  attr_reader :birthdate

  FORMAT = '%Y/%m/%d'.freeze
  CANT_BE_BLANK_MESSAGE = "can't be blank".freeze
  INVALID_DATE_FORMAT_MESSAGE = 'invalid date format'.freeze

  validate :is_date_valid?

  def initialize(date_string)
    @format = FORMAT
    @birthdate = date_string
    validate!
  end

  def is_date_valid?
    if @birthdate.nil?
      @birthdate = nil
      return
    end

    if @birthdate.empty? || @birthdate == ''
      errors.add(:birthdate, CANT_BE_BLANK_MESSAGE) if @birthdate == ''
      return
    end

    @birthdate = Date.strptime(@birthdate, FORMAT)
  rescue Date::Error
    errors.add(:birthdate, INVALID_DATE_FORMAT_MESSAGE)
  end
end
