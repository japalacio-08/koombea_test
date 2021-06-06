class CreateUploadedContactsFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :uploaded_contacts_files do |t|
      t.string :name
      t.string :document
      t.string :document_processing
      t.string :status
      t.string :fields_order
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
