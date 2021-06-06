class FailedContact < ApplicationRecord
  belongs_to :uploaded_contacts_file
  belongs_to :user
  validates_presence_of :row_number, :reason, :json_data

  FilterSerializer = Rack::Reducer.new(
    self.all,
    # ->(query_email:) { self.where(email: query_email) }, # This is an Example
  )
end
