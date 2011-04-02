class DecksController < ApplicationController
  before_filter :find_user

  def index
    @decks = params[:all] ? Deck.all : Deck.where(:active => true)
  end

  private

  def find_user
    @user = current_user
  end
end
