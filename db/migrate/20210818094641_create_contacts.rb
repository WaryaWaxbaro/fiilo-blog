class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :message
      t.text :extra_info

      t.timestamps
    end
  end
end
