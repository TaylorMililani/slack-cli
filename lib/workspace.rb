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
    @users.find do |user|
      if input == user.id
        selected_user = user
      elsif input == user.name
        selected_user = user
    end

    end
    return selected_user
  end

end



