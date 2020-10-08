require_relative 'recipient'

class Channel < Recipient
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
    query_params = {token: ENV["SLACK_TOKEN"]}

    response = self.get(url, query_params)

    channels_list = response["channels"].map do |channel|
      self.from_api(channel)
    end

    return channels_list
  end

  def select_channel
    #supply name or id to select channel
  end

  private

  def self.from_api(recipient)
    return new(
        slack_id: recipient["id"],
        name: recipient["name"],
        topic: recipient["topic"],
        member_count: recipient["num_members"]
    )
  end

end

