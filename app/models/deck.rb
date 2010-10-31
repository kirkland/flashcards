class Deck < ActiveRecord::Base
  has_many :cards
  accepts_nested_attributes_for :cards

  validates_format_of :bulk_cards, :with => /\A(.+\|.+\n?){1,}\z/, :on => :create
          
  def bulk_cards
    @bulk_cards || ""
  end

  def bulk_cards=(text)
    @bulk_cards ||= text
    cards = text.split("\n")
    cards.each do |card|
      front, back = card.split("|")
      Card.create(:deck => self, :front => front, :back => back)
    end
  end

  def card_attributes=(card_attributes)
    card_attributes.each do |attributes|
      if attributes[:id].blank?
        cards.build(attributes)
      else
        card = cards.detect {|t| t.id == attributes[:id].to_i }
        card.attributes = attributes
      end
    end
  end
end
