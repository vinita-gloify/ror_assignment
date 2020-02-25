class AddUserToLibraries < ActiveRecord::Migration[5.0]
  def change
    add_column :libraries, :user_references, :string
  end
end
