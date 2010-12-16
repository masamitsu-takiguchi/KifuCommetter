class AddNoteToKifuDocument < ActiveRecord::Migration
  def self.up
    add_column :kifu_documents, :note, :text
  end

  def self.down
    remove_column :kifu_documents, :note
  end
end
