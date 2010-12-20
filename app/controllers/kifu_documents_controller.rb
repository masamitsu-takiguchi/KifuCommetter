# -*- coding: utf-8 -*-
class KifuDocumentsController < ApplicationController
  respond_to :html, :xml, :js
  before_filter :check_user, :only => [:update, :edit, :destroy]

  # GET /kifu_documents/1/merge
  def merge
    @kifu_document = KifuDocument.new
    @parent_kifu_document = KifuDocument.find params[:id]
    @kifu_document.merged_kifu_documents << @parent_kifu_document
    pattern = /Rev\.(\d+)/
    if @parent_kifu_document.title.match pattern
      rev = @parent_kifu_document.title.scan(pattern).first.first
      @kifu_document.title = @parent_kifu_document.title.gsub(pattern, "Rev.#{rev.to_i + 1}")
    else
      @kifu_document.title =
        @parent_kifu_document.title + " Rev." + 
        (@parent_kifu_document.merged_kifu_documents.count + 1).to_s # Title Rev.1
    end
    respond_with @kifu_document
  end

  # GET /kifu_documents/download/1.orig.kif
  def send_original_kifu
    send_data NKF.nkf("-s", KifuDocument.find(params[:id]).kifu)
  end

  # GET /kifu_documents/download/1.kif
  def send_kifu
    send_data NKF.nkf("-s", merged_kifu(KifuDocument.find(params[:id])))
  end

  # GET /kifu_document/newp
  def new_with_plain_kifu
    @page_title = "新規投稿"
    @action = newp_kifu_document_url
    if request.get?
      @kifu_document = KifuDocument.new
      respond_with @kifu_document
    else
      @kifu_document = KifuDocument.new params[:kifu_document]
      @kifu_document.upload = false
      if @kifu_document.save
        respond_with @kifu_document do |format|
          format.html { redirect_to @kifu_document, :notice => "棋譜【#{@kifu_document.title}】を投稿しました！" }
        end
      else
        render :new_with_plain_kifu
      end
    end
  end

  # GET /kifudocuments/1/editu
  def edit_with_upload
    @page_title = "棋譜情報の編集"
    @action = editu_kifu_document_url
    if request.get?
      @kifu_document = KifuDocument.find params[:id]
      respond_with @kifu_document
    else
      @kifu_document = KifuDocument.find params[:id]
      if @kifu_document.update_attributes params[:kifu_document]
        respond_with @kifu_document do |format|
          format.html { redirect_to @kifu_document, :notice => "棋譜【#{@kifu_document.title}】を更新しました！" }
        end
      else
        render :edit_with_upload
      end
    end
  end

  # GET /kifudocuments/1.kifu
  def kifu
    @kifu_document = KifuDocument.find params[:id]
    @kifu = merged_kifu(@kifu_document)
    render :layout => false
  end

  # GET /kifudocuments/1.kif
  # (Shift_JIS)
  def kif
    @kifu_document = KifuDocument.find params[:id]
    @kif = NKF.nkf("-s", merged_kifu(@kifu_document))
    
    render :layout => false
  end

  # GET /kifu_documents
  # GET /kifu_documents.xml
  def index
    @kifu_documents = KifuDocument.order(:updated_at.desc).paginate(params[:page].to_i, nil)
    if not params[:page].blank?
      @morepage = params[:page].to_i + 1 
    else
      @morepage = 2
    end
    @morepage = nil if KifuDocument.paginate(params[:page].to_i+1, nil).count.zero?
    respond_with @kifu_documents
  end

  # GET /kifu_documents/1
  # GET /kifu_documents/1.xml
  def show
    @kifu_document = KifuDocument.find(params[:id])
    @form = Form.new
    @comment = Comment.new

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
        session[:user].kifu_document_ids[@kifu_document.id] = true
        format.html { redirect_to(@kifu_document, :notice => "棋譜【#{@kifu_document.title}】のアップロードに成功しました！") }
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

    respond_with @kifu_document do |format|
      if @kifu_document.update_attributes(params[:kifu_document])
        format.html { redirect_to(@kifu_document, :notice => "【#{@kifu_document.title}を更新しました！") }
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

  protected
  def check_user
    if not session[:user].kifu_document_ids.has_key? params[:id].to_i
      redirect_to kifu_documents_url, :notice => "許可されていない操作です。"
    end
  end

  private
  def merged_kifu kifu_document
    if kifu_document.merged_kifu_documents.blank?
      kifu_document.kifu
    else
      k1 = Kifu::Kifu.new kifu_document.kifu, kifu_document.uploaded_by
      logger.debug kifu_document.all_children.inspect
      kifu_document.all_children.each do |merged_kifu_document|
        k2 = Kifu::Kifu.new merged_kifu_document.kifu, merged_kifu_document.uploaded_by
        k1 = k1 & k2
      end 
      return k1.to_s
    end
  end
end
