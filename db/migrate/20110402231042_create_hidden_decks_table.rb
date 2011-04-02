class CreateHiddenDecksTable < ActiveRecord::Migration
  def self.up
    create_table :hidden_decks do |t|
      t.integer :deck_id
      t.integer :user_id

      t.timestamps
    end 
  end

  def self.down
    drop_table :hidden_decks
  end
end
