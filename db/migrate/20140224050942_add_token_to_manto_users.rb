class AddTokenToMantoUsers < ActiveRecord::Migration
  def change
    add_column :manto_users, :token, :string
    add_column :manto_users, :avatar, :string
  end
end
