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

  end



end
