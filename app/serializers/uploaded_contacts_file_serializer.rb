class UploadedContactsFileSerializer < ActiveModel::Serializer
  attributes :id, :name, :document_url, :status

  # def formated_event_date
  #   self.object.event_date.strftime("%m-%d-%Y")
  # end

  def document_url
    object.document.url
  end
  
end
