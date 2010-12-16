class AddKifuContentTypeToKifuDocument < ActiveRecord::Migration
  def self.up
    add_column :kifu_documents, :kifu_content_type, :string
  end

  def self.down
    remove_column :kifu_documents, :kifu_content_type
  end
end
