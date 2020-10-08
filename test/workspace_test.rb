require_relative 'test_helper'

describe "Workspace Class" do
  before do
    VCR.use_cassette("users and channels") do
      @workspace = Workspace.new
    end
  end

  describe "Workspace Instantiation"do
    it "is an instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end

    it "be able to read the attributes" do
      expect(@workspace).must_respond_to :users
      expect(@workspace).must_respond_to :channels
    end

    it "all of the attributes are correct datatypes" do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.channels).must_be_kind_of Array
    end

    it "can access the first user and channel" do
      first_user = @workspace.users.first

      expect(first_user).must_be_kind_of User
      expect(first_user.slack_id).must_equal "USLACKBOT"
      expect(first_user.name).must_equal "slackbot"
      expect(first_user.real_name).must_equal "Slackbot"
      expect(first_user.status_text).must_equal ""
      expect(first_user.status_emoji).must_equal ""

    end

    it "can access the first channel" do
      first_channel = @workspace.channels.first
      first_topic = {"value"=>"", "creater"=>"", "last_set"=>0}

      expect(first_channel).must_be_kind_of Channel
      expect(first_channel.slack_id).must_equal "C01C099NZ9B"
      expect(first_channel.name).must_equal "random"
      expect(first_channel.topic).must_equal first_topic
      expect(first_channel.member_count).must_equal 2

    end

  end

  describe "select user" do
    it "correctly selects the user" do
      user = @workspace.select_user("USLACKBOT")
      expect(user.slack_id).must_equal "USLACKBOT"
    end

    it "returns nil if the user is not found" do
      user = @workspace.select_user("Bobby")
      expect(user).must_be_nil
    end

    it "the argument should be case insensitive" do
      user = @workspace.select_user("UslackBOT")
      expect(user.slack_id).must_equal "USLACKBOT"
    end
  end

  describe "select channel" do
    it "correctly selects the channel" do
      channel = @workspace.select_channel("random")
      expect(channel.name).must_equal "random"
    end

    it "returns nil if the user is not found" do
      channel = @workspace.select_channel("plants")
      expect(channel).must_be_nil
    end

    it "the argument should be case insensitive" do
      channel = @workspace.select_channel("RANdom")
      expect(channel.name).must_equal "random"
    end
  end

  describe "send message" do
    it "is able to send a message" do
      VCR.use_cassette("send message") do
      answer = @workspace.send_message("C01C099NZ9B", "test message")
      expect(answer).must_equal true
      end
    end
    #failing
    it "raises an error for invalid channel" do
      VCR.use_cassette("send message error") do
      expect{
      answer = @workspace.send_message("bogus", "test message")
      }.must_raise SlackApiError
      end
    end
  end

end


