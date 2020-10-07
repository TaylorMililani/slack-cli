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

end



