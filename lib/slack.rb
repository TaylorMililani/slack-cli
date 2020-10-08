#!/usr/bin/env ruby
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  choices = ["list users", "list channels", "select user", "select channel", "details", "quit"]

  program_running = true

  while program_running
    puts "Please choose from the following:"

    choices.each_with_index do |choice, i|
      puts "#{i + 1}: #{choice}"
    end

    user_input = gets.chomp.downcase

    if user_input == "list users"
      pp workspace.users
    elsif user_input == "list channels"
      pp workspace.channels
    # elsif user_input == "select user"
      #select_user  if no user corresponds, print message and return to main command loop
    elsif user_input == "quit"
      program_running = false
    else
      puts "Invalid choice! Please try again!"
    end
  end

  puts "Thank you for using the Ada Slack CLI"


end

main if __FILE__ == $PROGRAM_NAME

# URL = "https://slack.com/api/conversations.list"
# query_params = {
#     token: ENV["SLACK_TOKEN"]
# }
# response = HTTParty.get(URL, query: query_params )
#
# pp response["channels"]