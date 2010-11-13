class Quiz < ActiveRecord::Base
  belongs_to :deck
  has_many :quiz_cards

  def create_quiz_cards
    deck.cards.each do |c|
      QuizCard.create(:quiz_id => id, :card_id => c.id, :visited => false)
    end
  end
  
  def next_card
    available_cards = quiz_cards.select{|c| c.visited == false}.shuffle
    if available_cards.empty?
      return "no more cards"
    end

    quiz_card = available_cards.pop
    quiz_card.update_attribute(:visited, true)
    quiz_card.card
  end
end
