class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.timestamps
      t.integer :short_id, null: false, index: true
      t.integer :user_id, null: false, index: true
    end
  end
end
