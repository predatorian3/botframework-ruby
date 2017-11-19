require 'oauth2'
require 'jwt'
require 'httparty'
require 'json'
require 'logger'

require 'bot_framework/version'
require 'bot_framework/errors'
require 'bot_framework/util'
require 'bot_framework/connector'
require 'bot_framework/api_base'
require 'bot_framework/conversation'
require 'bot_framework/bot_state'
require 'bot_framework/token_validator'
require 'bot_framework/bot'
require 'bot_framework/server'
# Models
require 'bot_framework/models/base'
require 'bot_framework/models/activity'
require 'bot_framework/models/api_response'
require 'bot_framework/models/attachment'
require 'bot_framework/models/animation_card'
require 'bot_framework/models/attachment_data'
require 'bot_framework/models/attachment_info'
require 'bot_framework/models/attachment_view'
require 'bot_framework/models/audio_card'
require 'bot_framework/models/bot_data'
require 'bot_framework/models/card_action'
require 'bot_framework/models/card_image'
require 'bot_framework/models/channel_account'
require 'bot_framework/models/conversation_account'
require 'bot_framework/models/conversation_parameters'
require 'bot_framework/models/entity'
require 'bot_framework/models/fact'
require 'bot_framework/models/geo_coordinates'
require 'bot_framework/models/hero_card'
require 'bot_framework/models/media_url'
require 'bot_framework/models/object'
require 'bot_framework/models/place'
require 'bot_framework/models/receipt_card'
require 'bot_framework/models/receipt_item'
require 'bot_framework/models/resource_response'
require 'bot_framework/models/signin_card'
require 'bot_framework/models/thumbnail_card'
require 'bot_framework/models/thumbnail_url'
require 'bot_framework/models/video_card'

# Dialog
require 'bot_framework/dialogs/entity_recognizer'
require 'bot_framework/dialogs/luis_recognizer'
require 'bot_framework/dialogs/reg_exp_recognizer'

# Microsoft's BotFramework RubyGem (Unofficial)
#
# Allows the use of the Microsoft BotFramework through Ruby.
module BotFramework
  class << self
    # Used to store the connector object which holds the configuration for the
    # BotFramework classes.
    attr_accessor :connector

    # Configure calls the bot_framework/connector file to take in a user's block
    # and configure the BotFramework agent.
    #
    # @param [Hash] *args
    # @param [Block] &block
    def configure(*args, &block)
      @connector = Connector.new(*args, &block)
    end

    # Uses the Rails Logger or Ruby Logger in order depending on how the Library is called.
    # Ruby Logger defaults to STDOUT unless defined otherwise.
    def logger
      @logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
    end
  end
end
