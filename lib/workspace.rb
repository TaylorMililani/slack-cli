require 'dotenv'
require 'httparty'

require_relative 'user'
require_relative 'channel'

Dotenv.load

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

end



