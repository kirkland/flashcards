class Deck < ActiveRecord::Base
  has_many :cards
  has_many :quizzes
  after_update :save_cards
  validates_associated :cards

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

  def save_cards
    cards.each do |c|
      if c.should_destroy?
        c.destroy
      else
        c.save(false)
      end
    end
  end

  def front_description
    return attributes[:front_description] if attributes[:front_description].present?
    "Front"
  end

  def back_description
    return attributes[:back_description] if attributes[:back_description].present?
    "Back"
  end
end
