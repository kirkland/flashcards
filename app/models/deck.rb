class Deck < ActiveRecord::Base
  has_many :cards
  accepts_nested_attributes_for :cards

  def bulk_cards
  end

  def bulk_cards=(text)
    cards = text.split("\n")
    cards.each do |card|
      front, back = card.split("|")
      Card.create(:deck => self, :front => front, :back => back)
    end
  end
end
