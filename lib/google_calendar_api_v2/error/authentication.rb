module GoogleCalendarApiV2
  class AuthenticationError < StandardError
     attr_reader :response
     def initialize(response)
        @response = response
     end
  end
end