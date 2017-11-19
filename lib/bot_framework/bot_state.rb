module BotFramework
  # The BotState class inherits all the methods and attributes of the ApiBase class.
  class BotState < ApiBase
    def initialize(service_url = nil)
      @service_url = service_url || 'https://state.botframework.com'
    end

    # Delete state for user
    #
    # Delete all data for a user in a channel (UserData and PrivateConversationData)
    #
    # @param [Hash] opts
    # @option opts [String] channel_id
    #   id for the channel to reply in.
    # @option opts [String] user_id
    #   id for the user on the channel.
    #
    # @return [Array<String>]
    def delete_state_for_user(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/users/#{opts['user_id']}"
      api_delete(uri)
    end

    # Get the conversation data
    #
    # get the bots data for all users in a conversation
    #
    # @param [Hash] opts
    # @option opts [String] channel_id
    #   the channelId
    # @option opts [String] conversation_id
    #   The id for the conversation on the channel
    #
    # @return [BotData]
    def get_conversation_data(opts = {})
      # opts['channel_id'] & opts['conversation_id']
      uri = "/v3/botstate/#{opts['channel_id']}/conversations/#{opts['conversation_id']}"
      BotFramework::BotData.new api_get(uri)
    end

    # Gets private conversation data
    #
    # get bot's data for a single user in a conversation
    #
    # @param [Hash] opts
    # @option opts [String] channel_id
    #   channelId
    # @option opts [String] conversation_id
    #   The id for the conversation on the channel
    # @option opts [String] user_id
    #   id for the user on the channel
    def get_private_conversation_data(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/conversations/#{opts['conversation_id']}/users/#{opts['user_id']}"
      BotFramework::BotData.new api_get(uri)
    end

    # Get a user's data
    #
    # Get a bots data for the user across all conversations
    #
    # @param [Hash] opts
    # @option opts [String] channel_id
    #   channelId
    # @option opts [String] user_id
    #   id for the user on the channel
    #
    # @return [BotData]
    def get_user_data(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/users/#{opts['user_id']}"
      BotFramework::BotData.new api_get(uri)
    end

    # Set conversation data
    #
    # Update the bot's data for all users in a conversation
    #
    # @param [Hash] opts
    # @option opts [String] channel_id
    #   channelId
    # @option opts [String] conversation_id
    #   The id for the conversation on the channel
    # @option opts [String] bot_data
    #   the new botdata
    #
    # @return [BotData]
    def set_conversation_data(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/conversations/#{opts['conversation_id']}"
      api_post(uri, opts['bot_data'])
    end

    # Sets private conversation data
    #
    # Update the bot's data for a single user in a conversation
    #
    # @param [Hash] opts
    # @option opts [String] channel_id
    #   channelId
    # @option opts [String] conversation_id
    #   The id for the conversation on the channel
    # @option opts [String] user_id
    #   id for the user on the channel
    # @option opts [String] bot_data
    #   the new botdata
    #
    # @return [BotData]
    def set_private_conversation_data(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/conversations/#{opts['conversation_id']}/users/#{opts['user_id']}"
      api_post(uri, opts['bot_data'])
    end
    # Sets the user's data
    #
    # Update the bot's data for a user
    #
    # @param [Hash] opts
    # @option opts [String] channel_id
    #   channelId
    # @option opts [String] user_id
    #   id for the user on the channel
    # @option opts [String] bot_data
    #   the new botdata
    #
    # @return [BotData]
    def set_user_data(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/users/#{opts['user_id']}"
      api_post(uri, opts['bot_data'])
    end
  end
end
