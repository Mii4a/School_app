class AddPictureToSchools < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :picture, :string
  end
end
