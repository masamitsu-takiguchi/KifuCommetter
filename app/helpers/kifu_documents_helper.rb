# -*- coding: utf-8 -*-
module KifuDocumentsHelper
  def tesuu_collection kifu_document
    cycle = "△"
    Kifu::Kifu.new(kifu_document.kifu)[0..-1].map{ |sashite|
      cycle = ((cycle == "▲") ? "△" : "▲")
      [sashite.tesuu.to_i, "#{sashite.tesuu}手目: #{cycle}#{sashite.te}"]
    }.unshift([nil, "通常コメント"])
  end
end
