class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.text :sub_title
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :schools, [:user_id, :created_at]
  end
end
