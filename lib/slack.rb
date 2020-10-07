#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  # workspace = Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

URL = "https://slack.com/api/conversations.list"
query_params = {
    token: ENV["SLACK_TOKEN"]
}
response = HTTParty.get(URL, query: query_params )

p response