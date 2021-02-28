class DateProvider
  def initialize
    @settable_date = nil
  end

  def define_now_date(now_date)
    @settable_date = now_date
  end

  def clean_now_date
    @settable_date = nil
  end

  def now
    return @settable_date unless @settable_date.nil?

    Time.now
  end
end
