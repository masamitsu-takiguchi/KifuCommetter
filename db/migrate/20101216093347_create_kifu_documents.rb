class CreateKifuDocuments < ActiveRecord::Migration
  def self.up
    create_table :kifu_documents do |t|
      t.references :kifu_documents
      t.string :title
      t.text :kifu
      t.string :uploaded_by
      t.references :categories

      t.timestamps
    end
  end

  def self.down
    drop_table :kifu_documents
  end
end
