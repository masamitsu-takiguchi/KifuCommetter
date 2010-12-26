# -*- coding: utf-8 -*-
require 'spec_helper'

describe KifuDocument, "棋譜が指定されていない場合:" do
  before(:each) do
    @kifudoc = KifuDocument.new
  end

  it "バリデーションに失敗すること" do
    @kifudoc.should_not be_valid
  end

  it ":kifu にエラーが設定されていること" do
    @kifudoc.should have(1).errors_on(:kifu)
  end
end

describe KifuDocument, "投稿者が設定されていない場合" do
  before :each do
    @kifu_document = KifuDocument.new
  end

  it "自動的に「名無しさん」になること」" do
    @kifu_document.kifu = "手数"
    @kifu_document.save!
    @kifu_document.uploaded_by.should == "名無しさん"
  end
end

describe KifuDocument do
  fixtures :kifu_documents, :forms_kifu_documents, :comments

  before :each do
    @sandmark = kifu_documents(:sandmark)
    @asanebou = kifu_documents(:asanebou)
  end

  it "は棋譜に属すること" do
    @asanebou.merged_kifu_documents.first.should == @sandmark
  end

  it "は複数の棋譜を持てること" do
    @asanebou.should have_at_least(1).merged_kifu_documents
  end

  it "は複数の戦型に属すること" do
    @sandmark.should have_at_least(2).forms
  end
end
