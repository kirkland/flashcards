class ReviewController < ApplicationController
  def show
    show_back = params[:show] == 'back'
    @deck_data = Deck.find(params[:id]).review_data(show_back).to_json
    @mobile = is_mobile?
  end
end
