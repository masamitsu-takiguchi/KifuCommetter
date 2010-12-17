class AddKifuDocumentIdToKifuDocument < ActiveRecord::Migration
  def self.up
    add_column :kifu_documents, :kifu_document_id, :integer
  end

  def self.down
    remove_column :kifu_documents, :kifu_document_id
  end
end
