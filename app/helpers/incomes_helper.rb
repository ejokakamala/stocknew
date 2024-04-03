module IncomesHelper
  def format_date(date, format = :long)
    date.blank? ? '' : date.to_s(format)
  end
end
