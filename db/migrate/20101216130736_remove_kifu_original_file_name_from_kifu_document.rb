class RemoveKifuOriginalFileNameFromKifuDocument < ActiveRecord::Migration
  def self.up
    remove_column :kifu_documents, :kifu_original_file_name
  end

  def self.down
    add_column :kifu_documents, :kifu_original_file_name, :string
  end
end
