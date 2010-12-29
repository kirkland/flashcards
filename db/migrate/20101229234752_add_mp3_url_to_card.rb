class AddMp3UrlToCard < ActiveRecord::Migration
  def self.up
    add_column :cards, :sound_url, :string, :limit => 512
  end

  def self.down
    remove_column :cards, :sound_url
  end
end
