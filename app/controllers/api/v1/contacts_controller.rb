class Api::V1::ContactsController < Api::ApplicationController
    before_action :authenticate_and_set_user

    before_action :get_contact, only: %i[show destroy]

    def index
        @records = Contact::FilterSerializer.apply(filter_params).order("id desc").with_paginate_10((filter_params[:page] || 1))
        success_response(data=bulk_serialize(ContactSerializer, @records, true))
    end

    def failed_contacts
        @records = FailedContact::FilterSerializer.apply(filter_params).order("id desc").with_paginate_10((filter_params[:page] || 1))
        success_response(data=bulk_serialize(FailedContactSerializer, @records, true))
    end

    def show
        success_response(data=serialize(ContactSerializer, @resource))
    end

    def imported_files
        @records = UploadedContactsFile::FilterSerializer.apply(filter_params).order("id desc").with_paginate_10((filter_params[:page] || 1))
        success_response(data=bulk_serialize(UploadedContactsFileSerializer, @records, true))
    end
    

    def importer
        @record = UploadedContactsFile.create!(event_params) {|record| record.status = 'on_hold'; record.user=@current_user }
        success_response(data=serialize(UploadedContactsFileSerializer, @record))
    end

    def destroy
        @resource.delete
        success_response(data=nil, message='The record has been deleted')
    end

    private

    def get_contact
        get_resource(Contact, 'id', params[:id])
    end

    def filter_params
        params.permit(:query_email, :page, :status)
    end
    

    def event_params
        params.permit(
            :name,
            :document,
            :fields_order
        )
    end
    
    
end
