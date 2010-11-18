class Quiz < ActiveRecord::Base
  belongs_to :deck
  has_many :quiz_cards

  def create_quiz_cards
    deck.cards.each do |c|
      QuizCard.create(:quiz_id => id, :card_id => c.id, :visited => false)
    end
  end
  
  def next_card(answer_result)
    prev_card = quiz_cards.detect{|q| q.active? }
    prev_card.update_attribute(:correct, answer_result == "correct") if prev_card.present?
    prev_card.update_attribute(:active, false) if prev_card.present?
    prev_card.update_attribute(:visited, true) if prev_card.present?

    available_cards = quiz_cards.select{|c| c.visited == false}.shuffle
    if available_cards.empty?
      return "no more cards"
    end

    next_card = available_cards.pop
    next_card.update_attribute(:active, true)
    next_card.card
  end

  def progress_string
    num_correct = quiz_cards.select{|x| x.correct == true}.count
    num_answered = quiz_cards.select{|x| x.visited == true}.count
    num_remaining = quiz_cards.length - num_answered

    "You have answered #{num_correct} of #{num_answered} cards correctly so far. You have #{num_remaining} remaining."
  end
end
