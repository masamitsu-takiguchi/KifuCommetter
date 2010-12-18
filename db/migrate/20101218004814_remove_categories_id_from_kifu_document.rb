class RemoveCategoriesIdFromKifuDocument < ActiveRecord::Migration
  def self.up
    remove_column :kifu_documents, :categories_id
  end

  def self.down
    add_column :kifu_documents, :categories_id, :integer
  end
end
