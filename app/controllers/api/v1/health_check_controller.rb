class Api::V1::HealthCheckController < Api::ApplicationController
    before_action :authenticate_and_set_user, only: [:who_am_i]
    def index
        success_response(
            message='Server is Up!!'
        )
    end

    def who_am_i
        success_response(
            data=@current_user
        )
    end
    
end
