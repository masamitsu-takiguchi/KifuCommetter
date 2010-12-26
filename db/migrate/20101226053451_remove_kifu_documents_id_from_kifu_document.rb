class RemoveKifuDocumentsIdFromKifuDocument < ActiveRecord::Migration
  def self.up
    remove_column :kifu_documents, :kifu_documents_id
  end

  def self.down
    add_column :kifu_documents, :kifu_documents_id, :integer
  end
end
