# -*- coding: utf-8 -*-
class Comment < ActiveRecord::Base
  belongs_to :kifu_document
  validates :message, :presence => true
  validates :kifu_document_id, :presence => true
  before_save :name_check

  PerPage = 5

  scope :belongs_to_kifu,
    where("comments.tesuu is not null")

  scope :of_kifu_document,
    lambda { |id| where(:kifu_document_id.eq => id).order(:created_at.desc) }

  scope :paginate,
    lambda { |page, per_page|
      page     = 1 if not page.present? or page <= 0
      per_page = PerPage if not per_page.present? or per_page <= 0
      limit = per_page
      offset = (page - 1) * limit

      limit(limit).offset(offset)
    }

  def name_check
    self.name = "名無しさん" if self.name.blank?
  end

  def kifu_document_id= id
    self.kifu_document = KifuDocument.find(id)
  end
end
