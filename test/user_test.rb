require_relative 'test_helper'

describe "User Class" do
  describe "User Instantiation"  do
    before do
      @user = User.new(
          slack_id: "U015QQ2BXFZ",
          name: "sarah",
          real_name: "Sarah Wilson",
          status_text: "feeling tired today",
          status_emoji: ":she:"
      )
    end

    it "is an instance of User" do
      expect(@user).must_be_kind_of User
    end

    it "Takes in user info" do
      expect(@user).must_respond_to :slack_id
      expect(@user.slack_id).must_equal "U015QQ2BXFZ"

      expect(@user).must_respond_to :name
      expect(@user.name).must_equal "sarah"

      expect(@user).must_respond_to :real_name
      expect(@user.real_name).must_equal "Sarah Wilson"

      expect(@user).must_respond_to :status_text
      expect(@user.status_text).must_equal "feeling tired today"

      expect(@user).must_respond_to :status_emoji
      expect(@user.status_emoji).must_equal ":she:"
    end

    it "all of the attributes must be string datatypes" do
      expect(@user.slack_id).must_be_kind_of String
      expect(@user.name).must_be_kind_of String
      expect(@user.real_name).must_be_kind_of String
      expect(@user.status_text).must_be_kind_of String
      expect(@user.status_emoji).must_be_kind_of String
    end

  end

  describe "list_all" do
    it "lists all users" do
      VCR.use_cassette("list_all") do

        response = User.list_all

        expect(response).must_be_kind_of Array
        expect(response.first).must_be_instance_of User
        expect(response.length).must_equal 5
      end
    end
  end

end



