# -*- coding: utf-8 -*-
require 'spec_helper'

describe KifuDocumentsController do

  def mock_kifu_document(stubs={})
    (@mock_kifu_document ||= mock_model(KifuDocument).as_null_object).tap do |kifu_document|
      kifu_document.stub(stubs) unless stubs.empty?
    end
  end

  describe "POST merge:" do
    let(:form1){ stub_model Form, :id => 1, :random_attribute => true }
    let(:form2){ stub_model Form, :id => 2, :random_attribute => true }

    it "親を持つ KifuDocument が作成される" do
      KifuDocument.stub(:find).with("47"){ mock_kifu_document }
      post :merge, :id => "47"
      assigns(:kifu_document).parent.should be(mock_kifu_document)
      assigns(:kifu_document).should be_a_new(KifuDocument)
    end

    pending "新たな KifuDocument が保存される" do
      KifuDocument.stub(:find).with("47"){ mock_kifu_document }
      post :merge, :id => "47"
      assigns(:kifu_document).should_receive :save
    end

    it "戦型が継承される" do
      KifuDocument.stub(:find).with("47"){
        mock_kifu_document(:forms => [form1, form2]) }
      post :merge, :id => "47"
      assigns(:kifu_document).forms.should have_at_least(2).forms
      assigns(:kifu_document).forms[0].should be(form1)
      assigns(:kifu_document).forms[1].should be(form2)
    end

    pending "@parent のタイトルが変わる" do
      KifuDocument.stub(:find).with("47"){
        mock_kifu_document(:title => "Title") }
      post :merge, :id => "47"
      assigns(:parent).should_receive :save
      assigns(:parent).title.should eq("Title Rev.1")
    end
  end

  describe "GET merge" do
    it "@parent に親がアサインされている" do
      KifuDocument.stub(:find).with("47"){ mock_kifu_document }
      get :merge, :id => "47"
      assigns(:parent).should be(mock_kifu_document)
    end

    it "@kifu_document に子がアサインされている" do
      KifuDocument.stub(:find).with("47"){ mock_kifu_document }
      get :merge, :id => "47"
      assigns(:kifu_document).should be_a_new(KifuDocument)
    end

    it "@merge が true になっている" do
      KifuDocument.stub(:find).with("47"){ mock_kifu_document }
      get :merge, :id => "47"
      assigns(:merge).should be_true
    end
  end

  describe "GET download/1.orig.kif:" do
    pending "文字コードがShiftJISになっていること" do
    end
  end

  describe "GET download/1.kif:" do
    pending "文字コードがShiftJISになっていること" do
    end
  end

  describe "GET index" do
    it "ページネーション" do
      get :index
      assigns(:page).should eq(1)
      get :index, :page => 3
      assigns(:page).should eq(3)
    end

    pending "assigns all kifu_documents as @kifu_documents" do
      KifuDocument.stub(:all) { [mock_kifu_document] }
      get :index
      assigns(:kifu_documents).should eq([mock_kifu_document])
    end
  end

  describe "GET show" do
    pending "assigns the requested kifu_document as @kifu_document" do
      KifuDocument.stub(:find).with("37") { mock_kifu_document }
      get :show, :id => "37"
      assigns(:kifu_document).should be(mock_kifu_document)
    end
  end

  describe "GET new" do
    pending "assigns a new kifu_document as @kifu_document" do
      KifuDocument.stub(:new) { mock_kifu_document }
      get :new
      assigns(:kifu_document).should be(mock_kifu_document)
    end
  end

  describe "GET edit" do
    pending "assigns the requested kifu_document as @kifu_document" do
      KifuDocument.stub(:find).with("37") { mock_kifu_document }
      get :edit, :id => "37"
      assigns(:kifu_document).should be(mock_kifu_document)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      pending "assigns a newly created kifu_document as @kifu_document" do
        KifuDocument.stub(:new).with({'these' => 'params'}) { mock_kifu_document(:save => true) }
        post :create, :kifu_document => {'these' => 'params'}
        assigns(:kifu_document).should be(mock_kifu_document)
      end

      pending "redirects to the created kifu_document" do
        KifuDocument.stub(:new) { mock_kifu_document(:save => true) }
        post :create, :kifu_document => {}
        response.should redirect_to(kifu_document_url(mock_kifu_document))
      end
    end

    describe "with invalid params" do
      pending "assigns a newly created but unsaved kifu_document as @kifu_document" do
        KifuDocument.stub(:new).with({'these' => 'params'}) { mock_kifu_document(:save => false) }
        post :create, :kifu_document => {'these' => 'params'}
        assigns(:kifu_document).should be(mock_kifu_document)
      end

      pending "re-renders the 'new' template" do
        KifuDocument.stub(:new) { mock_kifu_document(:save => false) }
        post :create, :kifu_document => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      pending "updates the requested kifu_document" do
        KifuDocument.should_receive(:find).with("37") { mock_kifu_document }
        mock_kifu_document.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :kifu_document => {'these' => 'params'}
      end

      pending "assigns the requested kifu_document as @kifu_document" do
        KifuDocument.stub(:find) { mock_kifu_document(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:kifu_document).should be(mock_kifu_document)
      end

      pending "redirects to the kifu_document" do
        KifuDocument.stub(:find) { mock_kifu_document(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(kifu_document_url(mock_kifu_document))
      end
    end

    describe "with invalid params" do
      pending "assigns the kifu_document as @kifu_document" do
        KifuDocument.stub(:find) { mock_kifu_document(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:kifu_document).should be(mock_kifu_document)
      end

      pending "re-renders the 'edit' template" do
        KifuDocument.stub(:find) { mock_kifu_document(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    pending "destroys the requested kifu_document" do
      KifuDocument.should_receive(:find).with("37") { mock_kifu_document }
      mock_kifu_document.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    pending "redirects to the kifu_documents list" do
      KifuDocument.stub(:find) { mock_kifu_document }
      delete :destroy, :id => "1"
      response.should redirect_to(kifu_documents_url)
    end
  end

end
