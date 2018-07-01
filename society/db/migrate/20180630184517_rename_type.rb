class RenameType < ActiveRecord::Migration[5.2]
  def change
      rename_column :clubs, :type, :category
  end
end
