require 'dotenv'
require 'httparty'

Dotenv.load

class SlackTokenError < StandardError; end

class Recipient

  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url, params)
    response = HTTParty.get(url, query: params)

    if response["ok"] != true
      raise SlackTokenError, "API call failed error message: #{response["error"]}"
    end

    return response
  end

  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end

  private

  def self.from_api(recipient)
    raise NotImplementedError, 'Implement me in a child class!'
  end

end


