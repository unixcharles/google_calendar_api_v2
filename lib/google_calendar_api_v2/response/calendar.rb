module GoogleCalendarApiV2
  module Response
    class Calendar
      include GoogleCalendarApiV2::Base
      include Base

      attr_reader :events

      def initialize(response, connection)
        super
        @events = GoogleCalendarApiV2::Event.new(@connection, self)
      end
    end
  end
end