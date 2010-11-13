class QuizCard < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :card
end
