class CreateBlogElements < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_elements, id: :uuid do |t|
      t.references :post, null: false, foreign_key: true, type: :uuid
      t.string :element_type
      t.string :blog_image_caption

      t.timestamps
    end
  end
end
