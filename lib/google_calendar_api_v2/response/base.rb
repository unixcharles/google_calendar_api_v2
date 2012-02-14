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

      def save
        res = @connection.put @attributes['selfLink'], self.to_json, GoogleCalendarApiV2::Client::HEADERS

        @attributes = JSON.parse(res.body)['data'] rescue @attributes
        if success? res
          true
        else
          false
        end
      end

      def destroy
        res = @connection.delete @attributes['selfLink'], GoogleCalendarApiV2::Client::HEADERS.merge({ 'If-Match' => '*' })
        if success? res
          true
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