module BotFramework
  # Performs typical Chat operations such as creating conversations, sending
  # messages, and replying to activities sent from BotFramework.
  # This class inherits all the methods and attr_accessor's from ApiBase
  # defined in bot_framework/api_base.
  class Conversation < ApiBase
    # Create a Conversation in the current Server, or Channel.
    #
    # Calls the api_post method defined in bot_framework/api_base
    #
    # @param [Hash] attributes
    def create(attributes)
      uri = '/v3/conversations'
      api_post(uri, attributes)
    end

    # Gets the activity's members
    #
    # Calls the api_get method defiend in bot_framework/api_base
    #
    # @param [String] conversation_id
    # @param [String] activity_id
    # @param [Hash] opts
    def get_activity_members(conversation_id, activity_id, opts = {})
      uri = "/v3/conversations/#{conversation_id}/activities/#{activity_id}/members"
      api_get(uri, opts)
    end
    
    # Gets the conversation's members
    #
    # Calls the api_get method from bot_framework/api_base
    #
    # @param [String] conversation_id
    def get_conversation_members(conversation_id)
      uri = "/v3/conversations/#{conversation_id}/activities/members"
      api_get(uri, opts)
    end

    # Sends an activity to BotFramework.
    #
    # Calls the api_post method from bot_framework/api_base
    #
    # @param [String] conversation_id
    # @param [Hash] activity
    def send(conversation_id, activity)
      uri = "/v3/conversations/#{conversation_id}/activities"
      api_post(uri, activity.as_json)
    end

    # Uploads an attachment to a conversation activity.
    #
    # Calls the api_post method from bot_framework/api_base
    #
    # @param [String] conversation_id
    # @param [Hash] opts
    def upload_attachment(conversation_id, opts = {})
      uri = "/v3/conversations/#{conversation_id}/attachments"
      api_post(uri, opts)
    end

    # Replies to an activity sent from BotFramework
    #
    # Calls the api_post method from bot_framework/api_base
    #
    # @param [String] conversation_id
    # @param [String] activity_id
    # @param [JSON] new_activity
    def reply_to_activity(conversation_id, activity_id, new_activity)
      uri = "/v3/conversations/#{conversation_id}/activities/#{activity_id}"
      api_post(uri, new_activity.to_hash)
    end
  end
end
