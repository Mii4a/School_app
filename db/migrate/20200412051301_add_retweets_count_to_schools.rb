class AddRetweetsCountToSchools < ActiveRecord::Migration[5.2]
  def self.up
    add_column :schools, :retweets_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :schools, :retweets_count
  end
end
