class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :username, :string, default: ""
      t.text :roles, array: true, default: ["member"]
      t.string :phone
      t.boolean :accept_terms, default: false

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end


