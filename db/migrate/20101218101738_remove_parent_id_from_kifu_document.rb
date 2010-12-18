class RemoveParentIdFromKifuDocument < ActiveRecord::Migration
  def self.up
    remove_column :kifu_documents, :parent_id
  end

  def self.down
    add_column :kifu_documents, :parent_id, :integer
  end
end
