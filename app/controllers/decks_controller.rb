class DecksController < ApplicationController
  before_filter :find_user
  before_filter :find_deck, :only => [:hide]

  def index
    if params[:all] || @user.nil?
      @decks = Deck.all
    else
      @decks = Deck.where(:active => true).not_hidden(current_user)
    end
  end

  def hide
    @deck.hide!(@user)
    flash[:notice] = "Deck \"#{@deck.title}\" is now hidden."
    redirect_to decks_path and return
  end

  private

  def find_user
    @user = current_user
  end

  def find_deck
    @deck = Deck.find(params[:id].to_i)
  end
end
