class AddContentToSchools < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :content, :text
  end
end
