class MoveActiveCardToQuiz < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :active_card_id, :integer
    remove_column :quiz_cards, :active
  end

  def self.down
    remove_column :quizzes, :active_card_id, :integer
    add_column :quiz_cards, :active, :boolean, :default => false
  end
end
