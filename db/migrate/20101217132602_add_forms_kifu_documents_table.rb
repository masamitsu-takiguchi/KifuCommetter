class AddFormsKifuDocumentsTable < ActiveRecord::Migration
  def self.up
    create_table :forms_kifu_documents, :id => false do |t|
      t.column :form_id, :integer
      t.column :kifu_document_id, :integer
    end
  end

  def self.down
    drop_table :forms_kifu_documents
  end
end
