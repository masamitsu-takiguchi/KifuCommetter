class AddTesuuToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :tesuu, :integer
  end

  def self.down
    remove_column :comments, :tesuu
  end
end
