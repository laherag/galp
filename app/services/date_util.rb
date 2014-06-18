class DateUtil

  class << self
 
    def beginning_of_last_month
      Date.today.last_month.beginning_of_month
    end

    def end_of_month
      Date.today.end_of_month
    end
    
    def date_from_string(string)
      if string and ! string.blank?
        string.to_date.strftime("%m/%d/%Y")
      end
    end

  def format_date(date)
    date ? date.strftime('%d/%m/%Y') : ''
  end

  end
  
end