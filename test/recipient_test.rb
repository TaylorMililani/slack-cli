require_relative 'test_helper'

describe "Recipient Class" do
  before do
    @recipient = Recipient.new("HD336D", "bobby")
  end

  describe "Recipient Instantiation"  do
    it "is an instance of Recipient" do
      expect(@recipient).must_be_kind_of Recipient
    end

    it "Takes in Recipient info" do
      expect(@recipient).must_respond_to :slack_id
      expect(@recipient.slack_id).must_equal "HD336D"

      expect(@recipient).must_respond_to :name
      expect(@recipient.name).must_equal "bobby"
    end

    it "all of the attributes are correct datatypes" do
      expect(@recipient.slack_id).must_be_kind_of String
      expect(@recipient.name).must_be_kind_of String
    end

  end

  describe "get method" do
    it "raises an error for invalid token" do
      VCR.use_cassette("list_all channels") do
        url = "https://slack.com/api/conversations.list"
        query_params = {token: "hdbsgf46876534"}

        expect{Recipient.get(url, query_params)}.must_raise SlackTokenError
      end
    end
  end

  describe "details method" do
    it "raises error if invoked through a recipient instance" do
      expect{@recipient.details}.must_raise NotImplementedError
    end
  end

  describe "list all method" do
    it "raises error if invoked through a Recipient Class" do
      expect{Recipient.list_all}.must_raise NotImplementedError
    end
  end

  describe "send message" do
    it "is able to send a message" do
      VCR.use_cassette("send message")


    end
  end

end