class TaggingTopics < ActiveRecord::Migration
  def change
    remove_column :shortened_urls, :topic_id
  end
end
