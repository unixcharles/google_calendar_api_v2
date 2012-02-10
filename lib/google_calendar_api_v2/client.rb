require 'oauth'

module GoogleCalendarApiV2
  class Client
    attr_reader :connection, :headers, :calendars, :events

    HEADERS = {'Content-Type' => 'application/json', 'GData-Version' => '2.6'}

    # Initialize this class with :consumer_key, :consumer_secret, :token, :token_secret
    def initialize(consumer_key, consumer_secret, token, token_secret)
      consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {
        :site               => "https://www.google.com",
        :scheme             => :header
      })

      @connection = OAuth::AccessToken.new(consumer,token, token_secret)

      @calendars = Calendar.new(@connection)
    end
  end
end