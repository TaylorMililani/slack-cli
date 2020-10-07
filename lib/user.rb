require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    "Slack ID: #{@slack_id}\nName: #{@name}\nReal Name: #{@real_name}\nStatus Text: #{@status_text}\nStatus Emoji: #{@status_emoji}"
  end

  def self.list_all
    url = "https://slack.com/api/users.list"
    query_params = {
        token: ENV["SLACK_TOKEN"]
    }

    response = self.get(url, query_params)

    return response["members"]
  end

end