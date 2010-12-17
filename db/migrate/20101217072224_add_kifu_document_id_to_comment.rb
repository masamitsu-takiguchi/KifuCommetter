class AddKifuDocumentIdToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :kifu_document_id, :integer
  end

  def self.down
    remove_column :comments, :kifu_document_id
  end
end
