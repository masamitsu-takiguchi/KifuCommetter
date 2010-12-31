# -*- coding: utf-8 -*-
class KifuDocument < ActiveRecord::Base
  acts_as_tree :order => :updated_at
  has_and_belongs_to_many :forms
  has_many :comments

  validates :kifu, :presence => true
  validate :proper_kifu?, :proper_path?

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

  def to_kifu
    Kifu::Kifu.new self.kifu, self.uploaded_by
  end

  def to_kifu_all
    kifu = Kifu::Kifu.new self.kifu, self.uploaded_by
    all_children.each do |child|
      kifu = kifu & Kifu::Kifu.new(child.kifu, child.uploaded_by)
      child.merge_comments! kifu
    end
    merge_comments! kifu
    kifu
  end

  def merge_comments! kifu
    self.comments.belongs_to_kifu.each do |comment|
      s = Kifu::Sashite.new(nil, nil, :merge => true, :tesuu => comment.tesuu,
                            :name => comment.name, :comment => comment.message)
      kifu.merge_comment! s
    end
  end

  def all_children
    self.all_children_map.flatten
  end

  def all_children_map
    if self.children.blank?
      return []
    else
      self.children.map do |kifu_document|
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

  def proper_path?
    errors.add(:kifu_file, 'が指定されていません。') if @kifu_file.blank? and @upload
  end

  def proper_kifu?
    if @upload and NKF.nkf('-w', self.kifu.to_s).match PatternOfDistinctKifuOrOtherData
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
