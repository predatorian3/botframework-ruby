module BotFramework
  # Connector class
  # Sets up and gets the OAuth token for Microsoft BotFramework and our bot to
  # communicate together and receive and send activities.
  class Connector
    # Holds the App ID provided by the Bots Framework.
    attr_accessor :app_id
    # Holds the Registered Bot's secret for authenticating.
    attr_accessor :app_secret
    # Holds the Bot's resulting Token after authenticating.
    attr_accessor :token
    
    # Constants for BotFrame::Connector
    CONFIG_URI = 'https://api.aps.skype.com/v1/.well-known/openidconfiguration'.freeze
    REFRESH_ENDPOINT = 'https://login.microsoftonline.com/botframework.com/oauth2/v2.0/token'.freeze
    REFRESH_SCOPE = 'https://api.botframework.com/.default'.freeze
    OPEN_ID_METADATA = 'https://login.botframework.com/v1/.well-known/openidconfiguration'.freeze
    BOT_CONNECTOR_ISSUER = 'https://api.botframework.com'.freeze
    MSA_OPEN_ID_METADATA = 'https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration'.freeze
    MSA_ISSUER = 'https://sts.windows.net/72f988bf-86f1-41af-91ab-2d7cd011db47/'.freeze
    MSA_AUDIENCE = 'https://graph.microsoft.com'.freeze
    EMULATOR_AUDIENCE_METADATA = 'https://login.microsoftonline.com/botframework.com/v2.0/.well-known/openid-configuration'.freeze
    EMULATOR_AUDIENCE = 'https://sts.windows.net/d6d49420-f39b-4df7-a1dc-d59a935871db/'.freeze
    STATE_END_POINT = 'https://state'.freeze
    ISSUER_DOMAINS = ['sts.windows.net', 'api.botframework.com', 'login.microsoftonline.com'].freeze

    # Initialize the BotFramework::Connector class.
    #
    # The initialize method also calls for a yeild block to allow for usrs to
    # pass in extra options such as app_id, app_secret and token.
    #
    # @param [Hash] options
    # @option options [String] :app_id
    # @option options [String] :app_secret
    def initialize(options = {})
      @app_id = options[:app_id]
      @app_secret = options[:app_secret]
      # Parse through our connector block.
      yield(self) if block_given?
    end

    # Populates the attr_accessor :client
    #
    # Creates the client object by getting the OAuth tokens for the BotFramework
    # so our bot can communicate and trust the BotFramework.
    #
    # @return [attr_accessor] :client
    def client
      OAuth2::Client.new(app_id, app_secret,
                         authorize_url: 'botframework.com/oauth2/v2.0/authorize',
                         token_url: 'botframework.com/oauth2/v2.0/token',
                         raise_errors: true,
                         site: 'https://login.microsoftonline.com')
    end
    
    #  Checks to see if our toekn is expired.
    # If it is expired then we'll renew our token so BotFramework will trust us.
    # Calls the get_token function if expired.
    #
    # @return [attr_accessor] :token
    def token
      @token = nil if @token && @token.expired?
      @token ||= get_token
      @token
    end
    
    # Calls the Class's attr_accessor :client and the client_credentials function
    # to return the token for BotFramework.
    #
    # @return [String] token
    def get_token
      client.client_credentials.get_token(scope: 'https://api.botframework.com/.default', token_method: :post)
    end
  end
end
