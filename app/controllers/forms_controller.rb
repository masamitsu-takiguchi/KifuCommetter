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
    @form = Form.find_by_name params[:form][:name]
    @form = Form.new params[:form] if not @form
    @kifu_document = KifuDocument.find params[:form][:kifu_document_id]
    begin
      @form.kifu_documents.find(@kifu_document.id)
    rescue ActiveRecord::RecordNotFound => e
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
    else
      redirect_to kifu_document_url(@kifu_document), :notice => "既に追加されています"
    end
  end
  
  def remove
    @form = Form.find params[:id]
    @kifu_document = KifuDocument.find params[:kid]
    @kifu_document.forms.delete(@form)
    url = session[:url]
    session[:url] = nil
    redirect_to url, :notice => "戦型【#{@form.name}】を取り消しました"
  end
  
  def destroy
    @form = Form.find params[:id]
    @form.destroy
    url = session[:url]
    session[:url] = nil
    redirect_to url, :notice => "戦型【#{@form.name}】を削除しました"
  end
end
