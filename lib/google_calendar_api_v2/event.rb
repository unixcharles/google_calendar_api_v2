module GoogleCalendarApiV2
  class Event
    include Base

    attr_reader :calendar

    def initialize(connection, calendar)
      @connection = connection
      @calendar = calendar
    end

    def find(event_token)
      url = "https://www.google.com/calendar/feeds/#{@calendar.token}/private/full/#{event_token}?alt=jsonc"
      response = @connection.get url, Client::HEADERS

      if success? response
        Response::Calendar.new(response, @connection)
      end
    end

    def create(params = {})
      response = @connection.post "/calendar/feeds/#{@calendar.token}/private/full?alt=jsonc",
      {
        :data => {
          :title => "Undefined event",
          :hidden => false
        }.merge(params)
      }.to_json, Client::HEADERS

      if success? response
        Response::Calendar.new(response, @connection)
      else
        response
      end
    end

  end
end