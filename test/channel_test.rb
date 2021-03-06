require_relative 'test_helper'

describe "Channel Class" do
  describe "Channel Instantiation"  do
    before do
      @topic = {
          "value"=>"plants",
          "creator"=>"slackbot",
          "last_set"=>1
      }

      @channel = Channel.new(
          slack_id: "U015QQ2BXF",
          name: "plants_and_gardening",
          topic: @topic,
          member_count: 2
      )
    end

    it "is an instance of Channel" do
      expect(@channel).must_be_kind_of Channel
    end

    it "Takes in Channel info" do
      expect(@channel).must_respond_to :slack_id
      expect(@channel.slack_id).must_equal "U015QQ2BXF"

      expect(@channel).must_respond_to :name
      expect(@channel.name).must_equal "plants_and_gardening"

      expect(@channel).must_respond_to :topic
      expect(@channel.topic).must_equal @topic

      expect(@channel).must_respond_to :member_count
      expect(@channel.member_count).must_equal 2
    end

    it "all of the attributes are correct datatypes" do
      expect(@channel.slack_id).must_be_kind_of String
      expect(@channel.name).must_be_kind_of String
      expect(@channel.topic).must_be_kind_of Hash
      expect(@channel.member_count).must_be_kind_of Integer
    end

  end

  describe "list_all" do
    it "lists all channels" do
      VCR.use_cassette("list_all channels") do

        response = Channel.list_all

        expect(response).must_be_kind_of Array
        expect(response.first).must_be_instance_of Channel
        expect(response.length).must_equal 3
      end
    end

    it "correctly list the attributes of the first channel" do
      VCR.use_cassette("list_all channels") do

        response = Channel.list_all

        first_channel = response.first

        first_topic = {"value"=>"", "creater"=>"", "last_set"=>0}

        expect(first_channel.slack_id).must_equal "C01C099NZ9B"
        expect(first_channel.name).must_equal "random"
        expect(first_channel.topic).must_equal first_topic
        expect(first_channel.member_count).must_equal 2
      end
    end

    describe "get method" do
      it "raises an error for invalid token" do
        VCR.use_cassette("list_all channels") do
          url = "https://slack.com/api/conversations.list"
          query_params = {token: "hdbsgf46876534"}

          expect{Channel.get(url, query_params)}.must_raise SlackTokenError
        end
      end
    end

  end


end
