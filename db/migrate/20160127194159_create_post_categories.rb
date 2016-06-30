class CreatePostCategories < ActiveRecord::Migration
  def change
    create_table :post_categories do |t|
      t.belongs_to :post, index: true
      t.belongs_to :category, index: true
      t.timestamps null: false
    end
  end
end
