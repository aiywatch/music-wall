class AddComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :song
      t.belongs_to :user
      t.string :comment
      t.integer :star

      t.timestamps
    end
  end
end
