module CatsHelper
  def localize_date(date)
    I18n.l date, format: :short if date
  end
end
