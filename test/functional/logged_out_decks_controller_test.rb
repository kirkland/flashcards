require 'test_helper'

class LoggedOutDecksControllerTest < ActionController::TestCase
  tests DecksController

  setup do
    @deck = Deck.make(:active => true)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:decks)
  end

  test 'should show an active deck' do
    get :index
    assert_select("#deck_#{@deck.id}")
  end

  test 'should not show a non-active deck' do
    @deck = Deck.make(:active => false)
    get :index
    assert_select("#deck_#{@deck.id}", false)
  end

  test 'should not show link to hide deck' do
    get :index
    assert_select("#deck_#{@deck.id} .hide_deck", false)
  end
end
