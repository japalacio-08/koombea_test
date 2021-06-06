class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :birthday
      t.string :telephone
      t.string :address
      t.string :credit_card
      t.string :franchise
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
