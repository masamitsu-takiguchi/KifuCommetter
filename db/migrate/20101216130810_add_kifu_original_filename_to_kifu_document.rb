class AddKifuOriginalFilenameToKifuDocument < ActiveRecord::Migration
  def self.up
    add_column :kifu_documents, :kifu_original_filename, :string
  end

  def self.down
    remove_column :kifu_documents, :kifu_original_filename
  end
end
