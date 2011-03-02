require File.dirname(__FILE__) + '/../spec_helper'

describe Deck do
  it { should validate_presence_of(:front_description) }
  it { should validate_presence_of(:back_description) }

  describe "#review_data" do
    before(:each) do
      @deck = Factory(:deck)
    end
  end
end
