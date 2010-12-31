# -*- coding: utf-8 -*-
require 'spec_helper'

describe Comment, ":message が設定されていない場合" do
  before :each do
    @comment = Comment.new
  end

  it "バリデーションに失敗すること" do
    @comment.should_not be_valid
  end

  it ":message にエラーが設定されていること" do
    @comment.should have(1).errors_on(:message)
  end
end

describe Comment, ":name が設定されていない場合" do
  before :each do
    @comment = Comment.new :kifu_document_id => 1
  end

  it "自動的に「名無しさん」になること" do
    @comment.message = "nil"
    @comment.save!
    @comment.name.should == "名無しさん"
  end
end

describe Comment do
  fixtures :comments, :kifu_documents

  before :each do
    @comment = comments :comment1
    @kifu_document1 = kifu_documents :sandmark
  end

  it "は特定の棋譜に属していること" do
    @comment.kifu_document.should == @kifu_document1
  end

  it "が棋譜に属していない場合は保存に失敗すること" do
    comments(:comment_null).save.should be_false
  end

  describe "Scopes: " do
    describe "belongs_to_kifu" do
      it "棋譜にコメントしてあるもののみ持ってくること" do
        Comment.belongs_to_kifu.count.should eq(1)
      end
    end
  end
end
