require 'spec_helper'

describe "kifu_documents/index.html.haml" do
  before(:each) do
    assign(:kifu_documents, [
      stub_model(KifuDocument,
        :kifu_documents => nil,
        :title => "Title",
        :kifu => "MyText",
        :uploaded_by => "Uploaded By",
        :categories => nil
      ),
      stub_model(KifuDocument,
        :kifu_documents => nil,
        :title => "Title",
        :kifu => "MyText",
        :uploaded_by => "Uploaded By",
        :categories => nil
      )
    ])
  end

  it "renders a list of kifu_documents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Uploaded By".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
