class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_error_message
    rescue_from ActiveRecord::RecordInvalid, with: :render_error_message_invalid_record


    def  create
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: :created
    end 



    private

    def signup_params
        params.permit(:time, :activity_id, :camper_id)
    end 

    def render_error_message
        render json: {errors: "Signup not found"}, status: 422
    end 

    def render_error_message_invalid_record(error)
        render json: {errors: error.record.errors.full_messages}, status: :unprocessable_entity
    end 
end
