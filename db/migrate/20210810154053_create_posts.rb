class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.text :intro
      t.boolean :publish, default: false
      t.datetime :publish_at
      t.string :slug
      t.string :category
      t.integer :views_count, default: 0

      t.timestamps
    end
  end
end
