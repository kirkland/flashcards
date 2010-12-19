class AddActiveFlagToDeck < ActiveRecord::Migration
  def self.up
    add_column :decks, :active, :boolean, :default => false
  end

  def self.down
    remove_column :decks, :active
  end
end
