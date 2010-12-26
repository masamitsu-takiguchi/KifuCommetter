# -*- coding: utf-8 -*-
require 'spec_helper'

describe Form, "name が設定されていない場合: " do
  before :each do
    @form = Form.new
  end

  it "Validationに失敗すること" do
    @form.should_not be_valid
  end

  it ":name にエラーが設定されていること" do
    @form.should have(1).errors_on(:name)
  end
end

describe Form, "name がユニークでない場合: " do
  fixtures :forms
  before :each do
    @yagura = forms(:yagura)
    @form   = Form.new :name => @yagura.name
  end

  it "Validationに失敗すること" do
    @form.should_not be_valid
  end

  it ":name にエラーが設定されていること" do
    @form.should have(1).errors_on(:name)
  end
end

describe Form do
  fixtures :forms, :kifu_documents, :forms_kifu_documents

  before :each do
    @form = forms :yagura
    @kifu1 = kifu_documents :sandmark
    @kifu2 = kifu_documents :asanebou
  end

  it "は複数の棋譜を持てること" do
    @form.should have_at_least(2).kifu_documents
  end

  it "は特定の棋譜に属すること" do
    @form.kifu_documents.where(:title => "sandmark").first == @kifu1
    @form.kifu_documents.where(:title => "asanebou").first == @kifu2
  end
end

describe Form, "kifu_document_id= が呼び出された場合" do
  fixtures :forms, :kifu_documents, :forms_kifu_documents

  before :each do
    @form = forms :yagura
    @asanebou = kifu_documents :asanebou
  end

  it "Form#kifu_documents に棋譜が追加されていること" do
    @form.kifu_document_id = @asanebou
    @form.kifu_documents.where(:title => "asanebou").first.should == @asanebou
  end
end
