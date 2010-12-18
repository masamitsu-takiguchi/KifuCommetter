# -*- coding: utf-8 -*-
class CommentsController < ApplicationController
  respond_to :html

  def create
    @comment = Comment.new params[:comment]
    @kifu_document = KifuDocument.find @comment.kifu_document_id
    if @comment.save
      respond_with @comment do |format|
        format.html { redirect_to kifu_document_path(@kifu_document), :notice => "コメントを投稿しました。" }
      end
    else
      @form = Form.new
      render :template => 'kifu_documents/show', :locals => {:kifu_document => @kifu_document}
    end
  end
end
