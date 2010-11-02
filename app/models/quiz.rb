class Quiz < ActiveRecord::Base
  belongs_to :deck

  serialize :game_data
end
