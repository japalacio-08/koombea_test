class FailedContactSerializer < ActiveModel::Serializer
  attributes :id, :row_number, :reason, :json_data, :document_url

  def json_data
    return JSON.parse(self.object.json_data)
  end

  def document_url
    return self.object.uploaded_contacts_file.document.url
  end
  
end
