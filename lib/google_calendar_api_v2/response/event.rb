module GoogleCalendarApiV2
  module Response
    class Event
      include Base

      attr_reader :calendar

      def initialize(response, connection, calendar)
        super
        @calendar = calendar
      end

    end
  end
end