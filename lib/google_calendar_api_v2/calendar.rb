module GoogleCalendarApiV2
  class Calendar
    include Base

    attr_reader :events

    def initialize(connection)
      @connection = connection
    end

    def find(calendar_token)
      url = "/calendar/feeds/default/allcalendars/full/#{calendar_token}?alt=jsonc"
      response = @connection.get url, Client::HEADERS
      if success? response
        Response::Calendar.new(response, @connection)
      end
    end

    def create(params = {})
      response = @connection.post '/calendar/feeds/default/owncalendars/full?alt=jsonc',
      {
        :data => {
          :title => "Unnamed calendar",
          :hidden => false
        }.merge(params)
      }.to_json, Client::HEADERS

      if success? response
        Response::Calendar.new(response, @connection)
      end
    end


  end
end