# frozen_string_literal: true

module MappingService
  class RequestBuilder
    def initialize(endpoint:, params:)
      self.endpoint = endpoint
      self.params = params
    end

    def call
      uri.query = encoded_params
      request = Net::HTTP::Get.new(path_with_encoded_params)
      client.request(request)
    end

    private

    attr_accessor :endpoint, :params

    def client
      @client ||= Net::HTTP.new(uri.host, uri.port).tap do |client|
        client.use_ssl = true if uri.instance_of?(URI::HTTPS)
      end
    end

    def uri
      @uri ||= URI(endpoint)
    end

    def path_with_encoded_params
      @path_with_encoded_params ||= "#{uri.path}?#{uri.query}"
    end

    def encoded_params
      @encoded_params ||= URI.encode_www_form(params)
    end
  end
end
