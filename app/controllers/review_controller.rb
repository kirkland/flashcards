class ReviewController < ApplicationController
  before_filter :find_browser_type

  def index
    @decks = params[:all] ? Deck.all : Deck.where(:active => true)
  end

  def show
    @deck_data = Deck.find(params[:id]).review_data.to_json
    @show = params[:show].present? ? params[:show] : "front"
  end

  private

  def find_browser_type
    @browser_type = request.user_agent =~ /Android/ ? "phone" : "regular"
  end
end
