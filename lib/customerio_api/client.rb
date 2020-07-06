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
      request(message_path(message_id))
    end

    def messages(limit: nil)

    end

    private

    def request(path)
      #http client request goes here
    end

    def message_path(message_id)
      "/v1/api/messages/#{message_id}"
    end

    def messages_path
      "/v1/api/messages"
    end
  end
end
