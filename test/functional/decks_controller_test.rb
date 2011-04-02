require 'test_helper'

class DecksControllerTest < ActionController::TestCase
  setup do
    @deck = Deck.make
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:decks)
  end
end
