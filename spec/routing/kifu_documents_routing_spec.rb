require "spec_helper"

describe KifuDocumentsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/kifu_documents" }.should route_to(:controller => "kifu_documents", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/kifu_documents/new" }.should route_to(:controller => "kifu_documents", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/kifu_documents/1" }.should route_to(:controller => "kifu_documents", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/kifu_documents/1/edit" }.should route_to(:controller => "kifu_documents", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/kifu_documents" }.should route_to(:controller => "kifu_documents", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/kifu_documents/1" }.should route_to(:controller => "kifu_documents", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/kifu_documents/1" }.should route_to(:controller => "kifu_documents", :action => "destroy", :id => "1")
    end

  end
end
