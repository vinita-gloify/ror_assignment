class ChangeLibraryFieldsTypes < ActiveRecord::Migration[5.0]
  def change
    change_column :libraries, :opening_time, :string
    change_column :libraries, :closing_time, :string
  end
end
