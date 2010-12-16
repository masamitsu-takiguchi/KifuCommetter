class AddKifuOriginalFileNameToKifuDocument < ActiveRecord::Migration
  def self.up
    add_column :kifu_documents, :kifu_original_file_name, :string
  end

  def self.down
    remove_column :kifu_documents, :kifu_original_file_name
  end
end
