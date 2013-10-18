class AddMessageTotalToHeroes < ActiveRecord::Migration
  def change
    add_column :heroes, :messages_total, :integer
    rename_column :heroes, :total, :heroes_total
  end
end
