class ChangeLongtextForCommentFromComments < ActiveRecord::Migration
  def self.up
    change_column :comments, :comment, :text, :limit => 4294967295
  end

  def self.down
    change_column :comments, :comment, :string
  end
end
