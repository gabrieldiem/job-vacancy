require 'date'

class CurrentDateProvider
  def initialize(current_date)
    @current_date = current_date
    @default_provider = Date
  end

  def today
    return @current_date unless @current_date.nil?

    @default_provider.today
  end
end
