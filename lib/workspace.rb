require 'dotenv'
require 'httparty'

Dotenv.load

class Workspace

  attr_reader :users, :channels

  def initialize
    @users = []
    @channels = []
  end

end
