module GoogleCalendarApiV2
  class Calendar
    include Base

    attr_reader :events

    def initialize(connection)
      @connection = connection
    end

    def find(calendar_token, url = nil, redirect_count = 0)
      url ||= "/calendar/feeds/default/allcalendars/full/#{calendar_token}?alt=jsonc"
      response = @connection.get url, Client::HEADERS

      raise 'Redirection Loop' if redirect_count > 3

      if success? response
        Response::Calendar.new(response, @connection)
      elsif redirect? response
        find(calendar_token, response['location'], redirect_count += 1)
      end
    end

    def create(params = {}, url = nil, redirect_count = 0)
      url ||= '/calendar/feeds/default/owncalendars/full?alt=jsonc'
      response = @connection.post url,
      {
        :data => {
          :title => "Unnamed calendar",
          :hidden => false
        }.merge(params)
      }.to_json, Client::HEADERS

      raise 'Redirection Loop' if redirect_count > 3

      if success? response
        Response::Calendar.new(response, @connection)
      elsif redirect?(response)
        create(params, response['location'], redirect_count += 1)
      end
    end


  end
end