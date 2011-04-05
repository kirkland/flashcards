require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  test "create new cards along with a new deck" do
    before_cards = Card.count
    d = Deck.create(:title => "some title", :front_description => "x", :back_description => "y", :bulk_cards => "one|two\nthree|four")
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

  test 'can hide a deck from a user' do
    d = Deck.make
    u = User.make

    assert !d.hidden?(u)
    d.hide!(u)
    assert d.hidden?(u)
  end

  test 'make sure new active deck is included in active scope' do
    assert_difference 'Deck.active.count' do
      Deck.make(:active => true)
    end
  end

  test 'make sure inactive deck not included in active scope' do
    assert_no_difference 'Deck.active.count' do
      Deck.make(:active => false)
    end
  end

  test 'make sure deck can be hidden from user' do
    u = User.make
    d = Deck.make

    # possible to use assert difference and pass the param: u?
    old_count = Deck.not_hidden(u).count
    d.hide!(u)
    assert_equal(old_count - 1, Deck.not_hidden(u).count)
  end
end
