class UploadedContactsFile < ApplicationRecord
  include AASM
  belongs_to :user
  validates_presence_of :document, :name, :fields_order
  mount_uploader :document, DocumentUploader

  FilterSerializer = Rack::Reducer.new(
    self.all,
    ->(status:) { self.where(status: status) },
  )

  aasm(:status) do
    state :on_hold, initial: true
    state :processing
    state :failed
    state :finished

    event :process, after: :process_file do
      transitions from: [:on_hold], to: :processing
    end

    event :fail do
      transitions from: [:processing], to: :failed
    end

    event :finish do
      transitions from: [:processing], to: :finished
    end
  end
  

  def process_file
    return true  if fields_order.length == 0
    
    order = fields_order.split(',')
    rows = CsvHelper.process_file(self.document.url, order)
    failed_contacts = []
    rows.each_with_index do |row, idx|
      begin
        Contact.create!(row) { |record| record.user_id = self.user.id; record.franchise = 'none' }
      rescue => e
        p e
        FailedContact.create!({
          uploaded_contacts_file_id: self.id,
          user: self.user,
          json_data: row.to_json,
          row_number: (idx+1),
          reason: e.message
        })
        failed_contacts << row
      end
    end
    self.fail! if rows.length == failed_contacts.length
    self.finish! if rows.length > failed_contacts.length
  rescue => e
    self.fail!
    raise e
  end
  
end
