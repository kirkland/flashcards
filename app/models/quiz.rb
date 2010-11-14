class Quiz < ActiveRecord::Base
  belongs_to :deck
  has_many :quiz_cards

  def create_quiz_cards
    deck.cards.each do |c|
      QuizCard.create(:quiz_id => id, :card_id => c.id, :visited => false)
    end
  end
  
  def next_card(answer_result)
    available_cards = quiz_cards.select{|c| c.visited == false}.shuffle
    if available_cards.empty?
      return "no more cards"
    end

    quiz_card = available_cards.pop
    quiz_card.update_attribute(:visited, true)
    quiz_card.update_attribute(:correct, answer_result == "correct")
    quiz_card.card
  end

  def progress_string
    num_correct = quiz_cards.select{|x| x.correct == true}.count
    num_answered = quiz_cards.select{|x| x.visited == true}.count - 1
    num_remaining = quiz_cards.length - num_answered

    "You have answered #{num_correct} of #{num_answered} so far. You have #{num_remaining} remaining."
  end
end
