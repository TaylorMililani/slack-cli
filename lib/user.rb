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
    query_params = {token: ENV["SLACK_TOKEN"]}

    response = self.get(url, query_params)

    users_list = response["members"].map do |member|
      self.from_api(member)
    end

    return users_list
  end

  def select_user
    #supply name or id to select user
  end

  private

  def self.from_api(recipient)
    return new(
        slack_id: recipient["id"],
        name: recipient["name"],
        real_name: recipient["real_name"],
        status_text: recipient["profile"]["status_text"],
        status_emoji: recipient["profile"]["status_emoji"]
    )
  end

end


# user = User.new(
#     slack_id: "U015QQ2BXFZ",
#     name: "sarah",
#     real_name: "Sarah Wilson",
#     status_text: "feeling tired today",
#     status_emoji: ":she:")
#
#
# pp User.list_all.first.slack_id
# pp User.list_all.first.name
# pp User.list_all.first.status_emoji
# pp User.list_all.first.status_text


pp User.list_all


