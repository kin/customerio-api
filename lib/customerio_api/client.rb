require 'net/http'

module CustomerioAPI
  class Client
    class InvalidRequest < RuntimeError; end
    class InvalidResponse < RuntimeError
      attr_reader :response

      def initialize(message, response)
        super(message)
        @response = response
      end
    end

    def initialize(site_id, secret_key)
      @username = site_id
      @passwork = secret_key
      @base_url = "https://beta-api.customer.io"
      @timeout = 10
    end

    def message(message_id)
      response = request(:get, message_path(message_id))
      verify_response(response)
    end

    def messages(**args)
      url_path = messages_path
      args.each_with_index do |arg, index|
        url_path += index == 0 ? '?' : '&'
        url_path += "#{arg.first.to_s}=#{arg.last}"
      end

      response = request(:get, url_path)
      verify_response(response)
    end

    private

    def request(type, path)
      uri = URI.join(@base_url, path)

      session = Net::HTTP.new(uri.host, uri.port)
      session.use_ssl = (uri.scheme == 'https')
      session.open_timeout = @timeout
      session.read_timeout = @timeout

      req = request_type(type).new(uri.path)
      req.basic_auth @username, @password

      session.start do |http|
        http.request(req)
      end
    end

    def verify_response(response)
      if response.code[0].to_i == 2
        response
      else
        raise InvalidResponse.new("CustomerIO returned an invalid response: #{response.code}", response)
      end
    end

    def message_path(message_id)
      "/v1/api/messages/#{message_id}"
    end

    def messages_path
      "/v1/api/messages"
    end

    def request_type(type)
      case type
      when :get
        Net::HTTP::Get
      else
        raise InvalidRequest.new("Invalid request: #{type}")
      end
    end
  end
end
