require 'dotenv'
require 'httparty'

Dotenv.load

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end
end