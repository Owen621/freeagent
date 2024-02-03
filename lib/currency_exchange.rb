#require "date"
#require "json"

module CurrencyExchange

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.

  #Common interface
  class ExchangeRate
    def fetch_exchange_rate(date, from_currency, to_currency)
      raise NotImplementedError, "No specified source type"
    end

    def get_date_str(date)
      return date.strftime("%Y-%m-%d")
    end
  end

  #Example class on how to extend the program to further file types
  class CSVExchangeRate < ExchangeRate
    def fetch_exchange_rate(date, from_currency, to_currency)
      #how to get the data from a csv file instead
    end
  end

  class JSONExchangeRate < ExchangeRate
    def fetch_exchange_rate(date, from_currency, to_currency)

      date_str = get_date_str(date)

      begin

        data = File.read(FILE_PATH)
        json_parsed = JSON.parse(data)

        if !json_parsed.key?(date_str)
          raise "Data not found on date #{date_str}"
        end
  
        values_on_date = json_parsed[date_str]
        if from_currency != FILE_CURRENCY && values_on_date[from_currency] == nil
          raise "There are no values for #{from_currency} on this date"
        elsif to_currency != FILE_CURRENCY && values_on_date[to_currency] == nil
          raise "There are no values for #{to_currency} on this date"
        end
        
        #Not sure if it's necessary but otherwise if the user did the to and
        # from as the file currency, this would error
        if to_currency == from_currency
          return 1

        elsif to_currency == FILE_CURRENCY
          exchange_rate = 1/values_on_date[from_currency]
        elsif from_currency == FILE_CURRENCY
          exchange_rate = values_on_date[to_currency]
        else
          exchange_rate = values_on_date[to_currency]/values_on_date[from_currency]
        end
          
        return exchange_rate
      
      rescue => e
        puts "There was an error reading from or parsing the JSON file - #{e.message}"
      end
      
    end
  end

  def self.rate(date, from_currency, to_currency)
    
    file_type_instance = determine_file_type
    if !file_type_instance.nil?
      exchange_rate = file_type_instance.fetch_exchange_rate(date, from_currency, to_currency)

      if !exchange_rate.nil?
        return exchange_rate
      end
    end
  end

  def self.determine_file_type

    begin
      file_extension = File.extname(FILE_PATH).delete_prefix('.')
      case file_extension
      when "json"
        return JSONExchangeRate.new
      ''' example on extending
      when "csv"
        return CSVExchangeRate.new
      '''
      else
        raise "File type invalid or not supported - #{file_extension}"
      end
    rescue => e
      puts "#{e.message}"
    end
  end

end

FILE_PATH = "../data/eurofxref-hist-90d.json"
FILE_CURRENCY = "EUR"
#puts CurrencyExchange.rate(Date.new(2018, 11, 22), "CAD", "GBP")