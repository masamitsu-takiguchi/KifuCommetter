# -*- coding: utf-8 -*-
class FormsController < ApplicationController
  respond_to :html

  # GET /forms/autocomplete
  def autocomplete
    @forms = Form.all
    respond_to do |format|
      format.json {
        render :text => {:query => params[:query], :suggestions => @forms.map{|form| form.name}}.to_json
      }
    end
  end

  # GET /forms
  def index
    @forms = Form.all
    respond_with @forms
  end

  def create
    @form = Form.new params[:form]
    @kifu_document = KifuDocument.find params[:form][:kifu_document_id]
    @form.kifu_documents << @kifu_document
    if @form.save
      @comments = @kifu_document.comments
      session[:user].form_ids[@form.id] = true
      redirect_to kifu_document_url(@kifu_document), :notice => "戦型【#{@form.name}】を追加しました。"
    else
      @kifu_document = KifuDocument.find(params[:form][:kifu_document_id])
      @comment = Comment.new
      render :template => 'kifu_documents/show', :locals => {:kifu_document => @kifu_document}
    end
  end
end
