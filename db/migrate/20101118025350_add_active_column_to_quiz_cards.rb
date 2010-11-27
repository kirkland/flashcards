class AddActiveColumnToQuizCards < ActiveRecord::Migration
  def self.up
    add_column :quiz_cards, :active, :boolean, :default => false
  end

  def self.down
    remove_column :quiz_cards, :active
  end
end
