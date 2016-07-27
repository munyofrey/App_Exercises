class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, index: true
      # add_index :users, :email
      t.timestamps
    end



  end
end
