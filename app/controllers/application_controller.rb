class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :bind_kifu_documents

  def bind_kifu_documents
    @kifudocs = KifuDocument.order(:updated_at.desc).limit(10)
  end
end
