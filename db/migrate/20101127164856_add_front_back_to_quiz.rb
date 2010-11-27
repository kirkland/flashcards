class AddFrontBackToQuiz < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :back_to_front, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :quizzes, :back_to_front
  end
end
