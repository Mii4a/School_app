class CreateSchoolChats < ActiveRecord::Migration[5.2]
  def change
    create_table :school_chats do |t|
      t.references :user, foreign_key: true
      t.references :school, foreign_key: true
      t.text :content

      t.timestamps
    end
    add_index :school_chats, [:school_id, :created_at]
  end
end
