require 'net/http'

module CustomerioAPI
  class Client

    def initialize(site_id, secret_key)
      @username = site_id
      @passwork = secret_key
      @base_url = "https://beta-api.customer.io"
      @timeout = 10
    end

    def message(message_id)
      request(:get, message_path(message_id))
    end

    def messages(limit: nil)
      request(:get, messages_path)
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
        # bad stuff
      end
    end
  end
end
