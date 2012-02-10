module GoogleCalendarApiV2
  module Base
    attr_reader :connection

    def success?(response)
      case response.code.to_i
      when 200, 201
        true
      else
        false
      end
    end
  end
end