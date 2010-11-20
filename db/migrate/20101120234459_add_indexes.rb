class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :quiz_cards, :quiz_id
  end

  def self.down
  end
end
