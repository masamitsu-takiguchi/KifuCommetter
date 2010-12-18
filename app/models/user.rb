# -*- coding: utf-8 -*-
# セッションに格納するユーザ情報
class User
  attr_accessor :kifu_document_ids, :comment_ids, :form_ids

  def initialize
    @kifu_document_ids = Hash.new
    @comment_ids = Hash.new
    @form_ids = Hash.new
  end
end
