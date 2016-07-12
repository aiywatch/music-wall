class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_hash

      t.timestamps
    end

    add_reference :songs, :user
  end
end
