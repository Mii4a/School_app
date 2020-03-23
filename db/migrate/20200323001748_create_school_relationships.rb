class CreateSchoolRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :school_relationships do |t|
      t.integer :student_id
      t.integer :school_id

      t.timestamps
    end
    add_index :school_relationships, :student_id
    add_index :school_relationships, :school_id
    add_index :school_relationships, [:student_id, :school_id], unique: true
  end
end
