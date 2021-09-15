class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_error_message
    rescue_from ActiveRecord::RecordInvalid, with: :render_error_message_invalid_record

    def index
        campers = Camper.all 
        render json: campers, status: :ok
    end 

    def show
        campers = Camper.find(params[:id])
        render json: campers, include: :activities, status: :ok
    end 


    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end 





    private

    def render_error_message
        render json: {error: "Camper not found"}, status: :not_found
    end 

    def camper_params
        params.permit(:name, :age)
    end

    def render_error_message_invalid_record(error)
        render json: {errors: error.record.errors.full_messages}, status: :unprocessable_entity
    end 
end
