#!/usr/bin/env ruby
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  choices = ["list users", "list channels", "select user", "select channel", "details", "send message", "quit"]

  program_running = true

  while program_running
    puts "Please choose from the following:"

    choices.each_with_index do |choice, i|
      puts "#{i + 1}: #{choice}"
    end

    user_input = gets.chomp.downcase

    case user_input
    when "list users"
      pp workspace.users
    when "list channels"
      pp workspace.channels
    when "select user"
      puts "User name or ID?"
      user = gets.chomp
      selected_item = workspace.select_user(user)
      if selected_item == nil
        puts "Hmm, no user matches that name or ID"
      end
    when "select channel"
      puts "Name or ID?"
      channel = gets.chomp
      selected_item = workspace.select_channel(channel)
      if selected_item == nil
        puts "Hmm, no channel matches that name or ID"
      end
    when "details"
      if selected_item != nil
        pp selected_item.details
      else
        puts "A channel or user has not been selected to show details"
      end
    when "send message"
      puts "Name or ID of channel?"
      channel = gets.chomp
      selected_channel = workspace.select_channel(channel)
      unless selected_channel == nil
        puts "What's your message?"
        text = gets.chomp
      end
      workspace.send_message(selected_channel, text)
    when "quit"
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
#
#     if user_input == "list users"
#       pp workspace.users
#     elsif user_input == "list channels"
#       pp workspace.channels
#     elsif user_input == "select user"
#       #select_user  if no user corresponds, print message and return to main command loop
#     elsif "quit"
#       program_running = false
#     else
#       puts "Invalid choice! Please try again!"
#     end