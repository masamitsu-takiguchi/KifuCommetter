# -*- coding: undecided -*-
class Comment < ActiveRecord::Base
  belongs_to :kifu_document

  validates :message, :presence => true

  before_save :name_check

  def name_check
    self.name = "名無しさん" if self.name.blank?
  end

  def kifu_document_id= id
    self.kifu_document = KifuDocument.find(id)
  end
end
