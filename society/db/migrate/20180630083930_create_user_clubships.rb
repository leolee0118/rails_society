class CreateUserClubships < ActiveRecord::Migration[5.2]
  def change
    create_table :user_clubships do |t|

      t.timestamps
    end
  end
end
