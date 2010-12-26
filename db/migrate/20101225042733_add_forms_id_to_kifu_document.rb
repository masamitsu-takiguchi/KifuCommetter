class AddFormsIdToKifuDocument < ActiveRecord::Migration
  def self.up
    add_column :kifu_documents, :forms_id, :integer
  end

  def self.down
    remove_column :kifu_documents, :forms_id
  end
end
