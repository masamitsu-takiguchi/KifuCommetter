# -*- coding: utf-8 -*-
class KifuDocument < ActiveRecord::Base
  belongs_to :kifu_document
  has_many :merged_kifu_documents, :class_name => 'KifuDocument'
  has_and_belongs_to_many :forms
  has_many :comments

  validates :kifu, :presence => true

  attr_accessor :upload

  before_save :title_check, :encode_kifu

  PatternOfDistinctKifuOrOtherData = /手数/
  PerPage = 3

  scope :paginate,
    lambda { |page, per_page|
      page     = 1 if not page.present? or page <= 0
      per_page = PerPage if not per_page.present? or per_page <= 0
      limit = per_page
      offset = (page - 1) * limit

      limit(limit).offset(offset)
    }

  def all_children
    self.all_children_map.flatten
  end

  def all_children_map
    if self.merged_kifu_documents.blank?
      return []
    else
      self.merged_kifu_documents.map do |kifu_document|
        [kifu_document] + kifu_document.all_children
      end
    end
  end

  def kifu_file= stream
    @kifu_file = stream
    unless @kifu_file.blank?
      self.kifu_original_filename = stream.original_filename
      self.kifu_content_type = stream.content_type
      self.kifu = stream.read
    end
  end

  def parent_kifu_document_id= kifu_document_id
    self.merged_kifu_documents << KifuDocument.find(kifu_document_id)
  end

  def parent_forms_ids= string
    array = string.split(',')
    self.forms = array.map{ |id| Form.find(id) }
  end

  def validate
    if @kifu_file.blank? and @upload
      errors.add(:kifu_file, 'が指定されていません。')
    elsif not NKF.nkf("-w", self.kifu).match PatternOfDistinctKifuOrOtherData and @upload
      errors.add(:kifu_file, 'は正式な棋譜ファイルではありません。')
    end
  end

  def title_check
    self.title = self.kifu_original_filename if title.blank?
    self.title = "無題" if title.blank? and not upload
    self.uploaded_by = "名無しさん" if self.uploaded_by.blank?
  end

  def encode_kifu
    self.kifu = NKF.nkf("-w", self.kifu)
  end
end
