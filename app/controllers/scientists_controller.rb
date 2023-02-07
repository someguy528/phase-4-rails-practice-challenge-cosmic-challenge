class ScientistsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :rescue_record_invalid
    def index
        scientists = Scientist.all 
        render json: scientists
    end

    def show
        scientist = Scientist.find(params[:id])
        render json: scientist, serializer: ScientistShowPlanetsSerializer, status: :ok
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end

    def update 
        scientist = Scientist.find(params[:id])
        scientist.update!(scientist_params)
        render json: scientist, status: :accepted
    end

    def destroy
        scientist = Scientist.find(params[:id])
        scientist.destroy
        head :no_content
    end

    private
    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end
    def rescue_record_not_found
        render json: {error: "Scientist not found"}, status: :not_found
    end
    def rescue_record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
