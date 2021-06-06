module ModelHelper
    def get_resource(class_, search_by, search_value)
        @resource = class_.find_by( "#{search_by}" => search_value)
        raise ExceptionHandler::NotFoundError.new(message="#{class_.to_s} not found") if @resource.nil?
    end

    def get_filtered_and_paginated_records(class_)
        class_::FilterSerializer.apply(filter_params).order("id desc").with_paginate_10((filter_params[:page] || 1))
    end
    
end