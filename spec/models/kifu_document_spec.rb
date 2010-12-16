# -*- coding: utf-8 -*-
require 'spec_helper'

describe KifuDocument, "棋譜が指定されていない場合:" do
  before(:each) do
    @kifudoc = KifuDocument.new
  end

  it "バリデーションに失敗すること" do
    @kifudoc.should_not be_valid
  end
end
