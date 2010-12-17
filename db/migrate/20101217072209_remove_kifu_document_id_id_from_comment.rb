class RemoveKifuDocumentIdIdFromComment < ActiveRecord::Migration
  def self.up
    remove_column :comments, :kifu_document_id_id
  end

  def self.down
    add_column :comments, :kifu_document_id_id, :integer
  end
end
