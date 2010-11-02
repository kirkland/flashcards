class CreateQuizzes < ActiveRecord::Migration
  def self.up
    create_table :quizzes do |t|
      t.integer :deck_id
      t.integer :user_id
      t.text :game_data # placeholder, perhaps, until I actually know what to store
      t.timestamps
    end
  end

  def self.down
    drop_table :quizzes
  end
end
