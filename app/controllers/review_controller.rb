class ReviewController < ApplicationController
  def show
    @deck_data = Deck.find(params[:id]).review_data.to_json
    @show = params[:show].present? ? params[:show] : "front"
    @mobile = is_mobile?
  end
end
