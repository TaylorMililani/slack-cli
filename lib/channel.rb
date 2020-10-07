require_relative 'recipient'

class User < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id:, name:, topic:, member_count:)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
    "Slack ID: #{@slack_id}\nName: #{@name}\nTopic: #{@topic}\nMember Count: #{@member_count}"
  end

  def self.list_all
    url = "https://slack.com/api/conversations.list"
    query_params = {
        token: ENV["SLACK_TOKEN"]
    }

    response = self.get(url, query_params)

    return response["channels"]
  end

end
