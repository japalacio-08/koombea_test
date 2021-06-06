class CreateFailedContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :failed_contacts do |t|
      t.integer :row_number
      t.references :uploaded_contacts_file, null: false, foreign_key: true
      t.string :reason
      t.string :json_data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
