require File.dirname(__FILE__) + '/../spec_helper'

describe Deck do
  it { should validate_presence_of(:front_description) }
  it { should validate_presence_of(:back_description) }

  describe "#review_data" do
    before(:each) do
      @deck = Factory(:deck, :bulk_cards => "hey front|hey back")
    end

    it "should return an array of a certain type of hash" do
      data = @deck.review_data
      data.first[:front].should == "hey front"
      data.first[:back].should == "hey back"
    end
  end
end
