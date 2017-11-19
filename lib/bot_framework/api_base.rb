require 'uri'

module BotFramework
  # Used to perform requests against the Microsoft BotFramework REST API
  # with some logging methods enabled.
  class ApiBase
    include HTTParty
    attr_accessor :service_url
    
    # Initialize the ApiBase object.
    #
    # @param [String] service_url
    #
    # @return [attr_accessor] :service_url
    def initialize(service_url)
      @service_url = service_url
    end
    
    # Performs a GET against the BotFramework REST API service URL.
    #
    # @param [String] local_uri
    # @param [Hash] _opts
    #   This parameter doesn't seem to be used, but only supplied to satisfy
    #   a need for it.
    #
    # @return [Hash] ???
    def api_get(local_uri, _opts = {})
      uri = URI.join(service_url, URI.escape(local_uri))
      BotFramework.logger.info uri
      JSON.parse(BotFramework.connector.token.get(uri).body)
    end
    
    # Performs a POST against the BotFramework to send requests or Activities
    # to the BotFramework.
    #
    # @param [String] local_uri
    # @param [Hash] opts
    #   The opts hash will be translated into JSON to be POSTed.
    #
    # @return [Hash] ???
    def api_post(local_uri, opts = {})
      uri = URI.join(service_url, URI.escape(local_uri))
      JSON.parse(BotFramework.connector.token.post(uri, body: opts.to_json,
                                                        headers: { 'Content-Type' => 'application/json' }).body)
    end

    # Performs a DELETE against the BotFramework.
    #
    # @param [String] local_uri
    def api_delete(local_uri)
      uri = URI.join(service_url, URI.escape(local_uri))
      BotFramework.connector.token.delete(uri)
    end

    # Performs a custom request against the BotFramework API.
    #
    # @param [String] method
    # @param [String] local_uri
    # @param [Hash] opts
    def api_request(method, local_uri, opts)
      uri = URI.join(service_url, URI.escape(local_uri))
      BotFramework.connector.token.request(method, uri, opts)
    end
  end
end
