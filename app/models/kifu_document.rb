# -*- coding: utf-8 -*-
class KifuDocument < ActiveRecord::Base
  belongs_to :kifu_document
  belongs_to :categories
  has_many :merged_kifu_documents, :class_name => 'KifuDocument'
  #has_and_belongs_to_many :categories
  has_and_belongs_to_many :forms
  has_many :comments

  validates :kifu, :presence => true

  attr_accessor :upload

  before_save :title_check, :encode_kifu

  PatternOfDistinctKifuOrOtherData = /手数/

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
