class AddRankTypeToClub < ActiveRecord::Migration[5.2]
  def change
      add_column :clubs, :rank, :string
      add_column :clubs, :type, :string
  end
end
