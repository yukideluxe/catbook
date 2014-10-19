module CatsHelper
  def localize_date(date)
    I18n.l date, format: :short
  end
end
