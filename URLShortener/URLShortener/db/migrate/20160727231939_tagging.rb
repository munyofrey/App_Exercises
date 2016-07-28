class Tagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :topic_id, null: false
      t.integer :short_id, null: false
    end

    create_table :tagging_topics do |t|
      t.string :topic
    end

    add_column :shortened_urls, :topic_id, :integer
  end
end
