class CreateQuizCardsTable < ActiveRecord::Migration
  def self.up
    create_table :quiz_cards do |t|
      t.integer :quiz_id, :Null => false
      t.integer :card_id, :Null => false
      t.boolean :visited, :default => false, :Null => false
      t.boolean :correct
    end

    remove_column :quizzes, :game_data
  end

  def self.down
    drop_table :quiz_cards
    add_column :quizzes, :game_data, :text
  end
end
