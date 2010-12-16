require 'spec_helper'

describe KifuDocumentsController do

  def mock_kifu_document(stubs={})
    (@mock_kifu_document ||= mock_model(KifuDocument).as_null_object).tap do |kifu_document|
      kifu_document.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all kifu_documents as @kifu_documents" do
      KifuDocument.stub(:all) { [mock_kifu_document] }
      get :index
      assigns(:kifu_documents).should eq([mock_kifu_document])
    end
  end

  describe "GET show" do
    it "assigns the requested kifu_document as @kifu_document" do
      KifuDocument.stub(:find).with("37") { mock_kifu_document }
      get :show, :id => "37"
      assigns(:kifu_document).should be(mock_kifu_document)
    end
  end

  describe "GET new" do
    it "assigns a new kifu_document as @kifu_document" do
      KifuDocument.stub(:new) { mock_kifu_document }
      get :new
      assigns(:kifu_document).should be(mock_kifu_document)
    end
  end

  describe "GET edit" do
    it "assigns the requested kifu_document as @kifu_document" do
      KifuDocument.stub(:find).with("37") { mock_kifu_document }
      get :edit, :id => "37"
      assigns(:kifu_document).should be(mock_kifu_document)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created kifu_document as @kifu_document" do
        KifuDocument.stub(:new).with({'these' => 'params'}) { mock_kifu_document(:save => true) }
        post :create, :kifu_document => {'these' => 'params'}
        assigns(:kifu_document).should be(mock_kifu_document)
      end

      it "redirects to the created kifu_document" do
        KifuDocument.stub(:new) { mock_kifu_document(:save => true) }
        post :create, :kifu_document => {}
        response.should redirect_to(kifu_document_url(mock_kifu_document))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved kifu_document as @kifu_document" do
        KifuDocument.stub(:new).with({'these' => 'params'}) { mock_kifu_document(:save => false) }
        post :create, :kifu_document => {'these' => 'params'}
        assigns(:kifu_document).should be(mock_kifu_document)
      end

      it "re-renders the 'new' template" do
        KifuDocument.stub(:new) { mock_kifu_document(:save => false) }
        post :create, :kifu_document => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested kifu_document" do
        KifuDocument.should_receive(:find).with("37") { mock_kifu_document }
        mock_kifu_document.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :kifu_document => {'these' => 'params'}
      end

      it "assigns the requested kifu_document as @kifu_document" do
        KifuDocument.stub(:find) { mock_kifu_document(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:kifu_document).should be(mock_kifu_document)
      end

      it "redirects to the kifu_document" do
        KifuDocument.stub(:find) { mock_kifu_document(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(kifu_document_url(mock_kifu_document))
      end
    end

    describe "with invalid params" do
      it "assigns the kifu_document as @kifu_document" do
        KifuDocument.stub(:find) { mock_kifu_document(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:kifu_document).should be(mock_kifu_document)
      end

      it "re-renders the 'edit' template" do
        KifuDocument.stub(:find) { mock_kifu_document(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested kifu_document" do
      KifuDocument.should_receive(:find).with("37") { mock_kifu_document }
      mock_kifu_document.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the kifu_documents list" do
      KifuDocument.stub(:find) { mock_kifu_document }
      delete :destroy, :id => "1"
      response.should redirect_to(kifu_documents_url)
    end
  end

end
