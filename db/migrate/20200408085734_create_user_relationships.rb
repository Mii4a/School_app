class CreateUserRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :user_relationships do |t|
      t.integer :followed_id
      t.integer :follower_id

      t.timestamps
    end
    add_index :user_relationships, :followed_id
    add_index :user_relationships, :follower_id
    add_index :user_relationships, [:followed_id, :follower_id]
  end
end
