class AddFrontBackDescripToDeck < ActiveRecord::Migration
  def self.up
    add_column :decks, :front_description, :string, :limit => 128
    add_column :decks, :back_description, :string, :limit => 128
  end

  def self.down
    remove_column :decks, :front_description
    remove_column :decks, :back_description
  end
end
