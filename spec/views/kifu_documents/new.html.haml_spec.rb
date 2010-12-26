require 'spec_helper'

describe "kifu_documents/new.html.haml" do
  before(:each) do
    assign(:kifu_document, stub_model(KifuDocument,
      :kifu_documents => nil,
      :title => "MyString",
      :kifu => "MyText",
      :uploaded_by => "MyString",
      :categories => nil
    ).as_new_record)
  end

  pending "renders new kifu_document form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => kifu_documents_path, :method => "post" do
      assert_select "input#kifu_document_kifu_documents", :name => "kifu_document[kifu_documents]"
      assert_select "input#kifu_document_title", :name => "kifu_document[title]"
      assert_select "textarea#kifu_document_kifu", :name => "kifu_document[kifu]"
      assert_select "input#kifu_document_uploaded_by", :name => "kifu_document[uploaded_by]"
      assert_select "input#kifu_document_categories", :name => "kifu_document[categories]"
    end
  end
end
