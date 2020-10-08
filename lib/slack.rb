#!/usr/bin/env ruby
require_relative 'workspace'

require 'table_print'

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
      puts ""
      tp workspace.users, :slack_id, :name, :real_name, :status_text, :status_emoji
      puts ""
    when "list channels"
      puts ""
      tp workspace.channels, :slack_id, :name, :topic, :member_count
      puts ""
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
        puts ""
        puts selected_item.details
        puts ""
      else
        puts "A channel or user has not been selected to show details"
      end
    when "send message"

      if selected_item != nil
        puts "What's your message?"
        text = gets.chomp

        workspace.send_message(selected_item.name, text)
      else
        puts "A channel or user has not been selected to send message"
      end

    when "quit"
      program_running = false
    else
      puts "Invalid choice! Please try again!"
    end
  end

  puts "Thank you for using the Ada Slack CLI"

end

main if __FILE__ == $PROGRAM_NAME
