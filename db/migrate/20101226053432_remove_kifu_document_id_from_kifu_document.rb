class RemoveKifuDocumentIdFromKifuDocument < ActiveRecord::Migration
  def self.up
    remove_column :kifu_documents, :kifu_document_id
  end

  def self.down
    add_column :kifu_documents, :kifu_document_id, :integer
  end
end
