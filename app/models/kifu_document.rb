# -*- coding: utf-8 -*-
class KifuDocument < ActiveRecord::Base
  belongs_to :kifu_documents
  belongs_to :categories

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
