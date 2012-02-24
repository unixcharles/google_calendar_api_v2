module GoogleCalendarApiV2
  class Event
    include Base

    attr_reader :calendar

    def initialize(connection, calendar)
      @connection = connection
      @calendar = calendar
    end

    def find(event_token, url = nil, redirect_count = 0)
      url ||= "https://www.google.com/calendar/feeds/#{@calendar.token}/private/full/#{event_token}?alt=jsonc"
      response = @connection.get url, Client::HEADERS

      raise 'Redirection Loop' if redirect_count > 3

      if success? response
        Response::Event.new(response, @connection, @calendar)
      elsif redirect? response
        find(event_token, response['location'], redirect_count += 1)
      end
    end

    def create(params = {}, url = nil, redirect_count = 0)
      url ||= "/calendar/feeds/#{@calendar.token}/private/full?alt=jsonc"

      response = @connection.post url,
      {
        :data => {
          :title => "Undefined event",
          :hidden => false
        }.merge(params)
      }.to_json, Client::HEADERS

      raise 'Redirection Loop' if redirect_count > 3

      if success? response
        Response::Event.new(response, @connection, @calendar)
      elsif redirect? response
        create(params, response['location'], redirect_count += 1)
      else
        false
      end
    end

  end
end