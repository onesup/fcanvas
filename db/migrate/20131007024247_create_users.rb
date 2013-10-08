class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :provider
      t.string :uid
      t.string :name
      t.string :relationship
      t.string :profile_image
      t.string :email
      t.text :data

      t.timestamps
    end
  end
end
