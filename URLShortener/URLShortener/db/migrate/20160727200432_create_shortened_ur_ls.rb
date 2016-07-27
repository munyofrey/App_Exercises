class CreateShortenedUrLs < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false, index: true
      t.string :short_url, null: false, uniqueness: true, index: true
      t.integer :user_id, presence: true, index: true
      t.timestamps
    end
  end

end
