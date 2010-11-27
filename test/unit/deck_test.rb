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
    d = Deck.create(:title => "some title", :bulk_cards => "some text")
    assert !d.valid?
    d = Deck.create(:title => "some title", :bulk_cards => "missing the back|")
    assert !d.valid?
    d = Deck.create(:title => "some title", :bulk_cards => "|missing the front")
    assert !d.valid?
  end

  test "new deck should create associated cards" do
    d = Deck.create(:title => "some title", :front_description => "x", :back_description => "y", :bulk_cards => "one|two\nthree|four")
    assert_not_equal [], d.cards
  end
end
