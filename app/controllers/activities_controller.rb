class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_error_message

    def index
        activities = Activity.all 
        render json: activities, status: :ok
    end 

    def destroy
        activities = Activity.find(params[:id])
        activities.destroy
    end 

    private

    def render_error_message
        render json: {error: "Activity not found"}, status: :not_found
    end 
end
