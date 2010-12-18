class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :bind_kifu_documents
  before_filter :find_user

  def bind_kifu_documents
    @kifudocs = KifuDocument.order(:updated_at.desc).limit(10)
  end

  protected
  def find_user
    session[:user] ||= User.new
  end
end
