class RequireFrontBackDescription < ActiveRecord::Migration
  def self.up
    change_column :decks, :front_description, :string, :limit => 128, :null => false
    change_column :decks, :back_description, :string, :limit => 128, :null => false
  end

  def self.down
  end
end
