require File.dirname(__FILE__) + '/../spec_helper'

describe Deck do
  it { should validate_presence_of(:front_description) }
  it { should validate_presence_of(:back_description) }

  describe "#review_data" do
    before(:each) do
      @deck = Factory(:deck)
      @card = Factory(:card, :deck_id => @deck.id)
    end

    it "should return an array of a certain type of hash" do
      data = @deck.review_data
      data.first[:front].should == @card.front
      data.first[:back].should == @card.back
    end
  end
end
