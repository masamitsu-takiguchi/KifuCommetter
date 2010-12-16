require 'spec_helper'

describe "kifu_documents/show.html.haml" do
  before(:each) do
    @kifu_document = assign(:kifu_document, stub_model(KifuDocument,
      :kifu_documents => nil,
      :title => "Title",
      :kifu => "MyText",
      :uploaded_by => "Uploaded By",
      :categories => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Uploaded By/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
