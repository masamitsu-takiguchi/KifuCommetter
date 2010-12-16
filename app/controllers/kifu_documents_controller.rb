# -*- coding: utf-8 -*-
class KifuDocumentsController < ApplicationController
  respond_to :haml, :xml
  # GET
  def new_with_plain_kifu
    @page_title = "新規投稿"
    if request.get?
      @kifu_document = KifuDocument.new
      respond_with @kifu_document
    else
      @kifu_document = KifuDocument.new params[:kifu_document]
      if @kifu_document.save
        respond_with @kifu_document do |format|
          format.html { redirect_to kifu_documents_url, :notice => "棋譜【#{@kifu_document.title}】のアップロードに成功しました！" }
        end
      else
        render :new_with_plain_kifu
      end
    end
  end

  # GET /kifu_documents
  # GET /kifu_documents.xml
  def index
    @kifu_documents = KifuDocument.order(:updated_at.desc)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kifu_documents }
    end
  end

  # GET /kifu_documents/1
  # GET /kifu_documents/1.xml
  def show
    @kifu_document = KifuDocument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kifu_document }
    end
  end

  # GET /kifu_documents/new
  # GET /kifu_documents/new.xml
  def new
    @kifu_document = KifuDocument.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @kifu_document }
    end
  end

  # GET /kifu_documents/1/edit
  def edit
    @kifu_document = KifuDocument.find(params[:id])
  end

  # POST /kifu_documents
  # POST /kifu_documents.xml
  def create
    @kifu_document = KifuDocument.new(params[:kifu_document])

    respond_to do |format|
      if @kifu_document.save
        format.html { redirect_to(@kifu_document, :notice => 'Kifu document was successfully created.') }
        format.xml  { render :xml => @kifu_document, :status => :created, :location => @kifu_document }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @kifu_document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kifu_documents/1
  # PUT /kifu_documents/1.xml
  def update
    @kifu_document = KifuDocument.find(params[:id])

    respond_to do |format|
      if @kifu_document.update_attributes(params[:kifu_document])
        format.html { redirect_to(@kifu_document, :notice => 'Kifu document was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kifu_document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kifu_documents/1
  # DELETE /kifu_documents/1.xml
  def destroy
    @kifu_document = KifuDocument.find(params[:id])
    @kifu_document.destroy

    respond_to do |format|
      format.html { redirect_to(kifu_documents_url) }
      format.xml  { head :ok }
    end
  end
end
