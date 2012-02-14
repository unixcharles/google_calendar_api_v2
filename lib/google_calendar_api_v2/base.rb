module GoogleCalendarApiV2
  module Base
    attr_reader :connection


    private

    def success?(response)
      case response.code.to_i
      when 200, 201
        true
      when 401
        raise GoogleCalendarApiV2::AuthenticationError.new response
      else
        false
      end
    end
  end
end