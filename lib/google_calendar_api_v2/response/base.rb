require 'json'

module GoogleCalendarApiV2
  module Response
    module Base
      attr_reader :response, :attributes

      def initialize(response, connection, parent = nil)
        @response, @connection = response, connection
        @attributes = JSON.parse(response.body)['data'] rescue {}
      end

      def update_attributes(attributes)
        @attributes.merge!(attributes)
      end

      def []=(key, value)
        @attributes[key.to_s]=value
      end

      def [](key)
        @attributes[key.to_s]
      end

      def to_json
        {
          "apiVersion" => "2.3",
          :data => @attributes
        }.to_json
      end

      def save(url = nil, redirect_count = 0)
        url ||= @attributes['selfLink']
        response = @connection.put url, self.to_json, GoogleCalendarApiV2::Client::HEADERS

        raise 'Redirection Loop' if redirect_count > 3

        if success? response
          @attributes = JSON.parse(res.body)['data'] rescue @attributes
          true
        elsif redirect? response
          save(response['location'], redirect_count += 1)
        else
          false
        end
      end

      def destroy(url = nil, redirect_count = 0)
        url ||= @attributes['selfLink']
        response = @connection.delete url, GoogleCalendarApiV2::Client::HEADERS.merge({ 'If-Match' => '*' })

        raise 'Redirection Loop' if redirect_count > 3

        if success? response
          true
        elsif redirect? response
          destroy(response['location'], redirect_count += 1)
        else
          false
        end
      end

      def token
        @attributes['id'].split('/').last
      end

    end
  end
end