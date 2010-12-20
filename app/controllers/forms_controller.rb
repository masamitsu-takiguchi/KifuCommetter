# -*- coding: utf-8 -*-
class FormsController < ApplicationController
  respond_to :html

  # GET /forms/autocomplete
  def autocomplete
    @forms = Forms.all
    respond_to do |format|
      format.json {
        render :text => {:query => params[:query], :suggestions => @forms}.to_json
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
    if @form.save
      session[:user].form_ids[@form.id] = true
      respond_with @forms do |format|
        format.html { redirect_to kifu_document_url(params[:form][:kifu_document_id]), :notice => "戦型【#{@form.name}】を追加しました。" }
      end
    else
      @kifu_document = KifuDocument.find(params[:form][:kifu_document_id])
      @comment = Comment.new
      render :template => 'kifu_documents/show', :locals => {:kifu_document => @kifu_document}
    end
  end
end
