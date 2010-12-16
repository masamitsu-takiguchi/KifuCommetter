# -*- coding: utf-8 -*-
class KifuDocument < ActiveRecord::Base
  belongs_to :kifu_documents
  belongs_to :categories

  validates :kifu, :presence => true

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
    if @kifu_file.blank?
      errors.add(:kifu_file, 'が指定されていません。')
    elsif not NKF.nkf("-w", self.kifu).match PatternOfDistinctKifuOrOtherData
      errors.add(:kifu_file, 'は正式な棋譜ファイルではありません。')
    end
  end

  def before_save
    self.title = self.kifu_original_filename if title.blank?
    self.uploaded_by = "名無しさん" if self.uploaded_by.blank?
    self.kifu = NKF.nkf("-w", self.kifu)
  end
end
