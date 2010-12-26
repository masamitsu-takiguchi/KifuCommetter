class AddParentIdToKifuDocument < ActiveRecord::Migration
  def self.up
    add_column :kifu_documents, :parent_id, :integer
  end

  def self.down
    remove_column :kifu_documents, :parent_id
  end
end
