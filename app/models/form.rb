class Form < ActiveRecord::Base
  has_and_belongs_to_many :kifu_documents

  validates :name, :presence => true, :uniqueness => true

  def kifu_document_id= id
    self.kifu_documents << KifuDocument.find(id)
  end
end
