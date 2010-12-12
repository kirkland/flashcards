class Quiz < ActiveRecord::Base
  belongs_to :deck
  belongs_to :user
  has_many :quiz_cards

  def start_quiz
    deck.cards.shuffle.each do |c|
      QuizCard.create(:quiz_id => id, :card_id => c.id, :visited => false)
    end
  end

  def quiz_status
    num_correct = quiz_cards.correct.count
    num_answered = quiz_cards.where("correct IS NOT NULL").count
    num_remaining = quiz_cards.length - num_answered
    
    {:num_correct => num_correct, :num_answered => num_answered, :num_remaining => num_remaining, :percent_correct => num_answered == 0 ? 0 : num_correct.to_f/num_answered}
  end

  def data
    cards_data = quiz_cards.collect do |qc|
      {
        :front => back_to_front ? qc.back : qc.front,
        :back => back_to_front ? qc.front : qc.back,
        :correct => qc.correct,
        :visited => qc.visited,
        :id => qc.id
      }
    end
    { :quiz_cards => cards_data, :active_card_id => active_card_id}
  end
end
