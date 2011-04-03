require 'test_helper'

class LoggedInDecksControllerTest < ActionController::TestCase
  tests DecksController

  setup do
    @deck = Deck.make(:active => true)

    @user = User.make
    @user_session = UserSession.create(@user)
  end

  test 'should not show a non-active deck' do
    @deck = Deck.make(:active => false)
    get :index
    assert_select("#deck_#{@deck.id}", false)
  end

  test 'should see link to hide deck' do
    get :index
    assert_select("#deck_#{@deck.id} .hide_deck")
  end
end
