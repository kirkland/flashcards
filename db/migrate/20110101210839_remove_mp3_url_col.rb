class RemoveMp3UrlCol < ActiveRecord::Migration
  def self.up
    remove_column :cards, :sound_url
  end

  def self.down
    add_column :cards, :sound_url, :string, :limit => 512
  end
end
