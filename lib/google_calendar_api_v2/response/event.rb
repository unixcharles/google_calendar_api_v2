module GoogleCalendarApiV2
  module Response
    class Event
      include GoogleCalendarApiV2::Base
      include Base

      attr_reader :calendar

      def initialize(response, connection, calendar)
        super
        @calendar = calendar
      end

    end
  end
end