require 'dotenv'
require 'httparty'

require_relative 'user'
require_relative 'channel'

Dotenv.load

class SlackApiError < StandardError; end

class Workspace

  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  def select_user(input)
    selected = @users.find { |user| user.slack_id.upcase == input.upcase || user.name.upcase == input.upcase}

    return selected

  end

  def select_channel(input)
    selected = @channels.find { |channel| channel.slack_id.upcase == input.upcase || channel.name.upcase == input.upcase}

    return selected
  end

  def send_message(selected_item, text)
    url = "https://slack.com/api/chat.postMessage"
    response = HTTParty.post(url,
        body:  {
            token: ENV["SLACK_TOKEN"],
            text: text,
            channel: selected_item
        },
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )
    unless response.parsed_response["ok"] == true
      raise SlackApiError, "Error: #{response.parsed_response["error"]}"
    end

    return true
  end

end



