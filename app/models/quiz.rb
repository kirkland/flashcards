class Quiz < ActiveRecord::Base
  belongs_to :deck
  belongs_to :user
  has_many :quiz_cards

  def start_quiz
    deck.cards.each do |c|
      QuizCard.create(:quiz_id => id, :card_id => c.id, :visited => false)
    end
  end
  
  def next_card(answer_result)
    prev_card = quiz_cards.detect{|q| q.active? }
    prev_card.update_attribute(:correct, answer_result == "correct") if prev_card.present?
    prev_card.update_attribute(:active, false) if prev_card.present?
    prev_card.update_attribute(:visited, true) if prev_card.present?

    available_cards = quiz_cards.not_visited
    if available_cards.empty?
      return "no more cards"
    end

    next_card = available_cards.sample
    next_card.update_attribute(:active, true)
    next_card.card
  end

  def quiz_status
    num_correct = quiz_cards.correct.count
    num_answered = quiz_cards.visited.count
    num_remaining = quiz_cards.length - num_answered
    
    {:num_correct => num_correct, :num_answered => num_answered, :num_remaining => num_remaining, :percent_correct => num_answered == 0 ? 0 : num_correct.to_f/num_answered}
  end

  def data
    quiz_cards.collect do |qc|
      {
        :front => qc.front,
        :back => qc.back,
        :correct => qc.correct,
        :visited => qc.visited,
        :active => qc.active
      }
    end
  end
end
