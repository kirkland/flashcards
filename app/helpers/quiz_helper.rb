module QuizHelper
  def order_string(quiz)
    return "Deck #{quiz.deck_id} deleted" if quiz.deck.nil?
    quiz.back_to_front? ? "#{quiz.deck.back_description} -> #{quiz.deck.front_description}" : "#{quiz.deck.front_description} -> #{quiz.deck.back_description}"
  end
end
