require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  test "create new cards along with a new deck" do
    before_cards = Card.count
    d = Deck.create(:title => "some title", :bulk_cards => "one|two\nthree|four")
    assert_equal before_cards + 2, Card.count
  end

  test "new deck should reject malformed card text" do
    d = Deck.create(:title => "some title", :bulk_cards => "one|two\nthree four") # note: would need a '|'
    assert !d.valid?
  end
end
