require 'test_helper'

class DecksControllerTest < ActionController::TestCase
  setup do
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:decks)
  end

  test "should show an active deck" do
    @deck = Deck.make(:active => true)
    get :index
    assert_select("#deck_#{@deck.id}")
  end
end
