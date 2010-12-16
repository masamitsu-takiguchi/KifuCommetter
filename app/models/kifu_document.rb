class KifuDocument < ActiveRecord::Base
  belongs_to :kifu_documents
  belongs_to :categories
end
