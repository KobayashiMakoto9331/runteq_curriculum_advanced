class AddColunmToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :eyecatch_width, :integer
    add_column :articles, :eyecatch_position, :integer, default: 0, null: false
  end
end
