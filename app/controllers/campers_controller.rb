class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :show_errors

    def index
        render json: Camper.all
    end

    def show
        camper = find_camper
        render json: camper, status: :ok
    end

    def create 
        camper = Camper.create!(camper_params)
        render json: camper
    end

    # def update 
    #     camper = find_camper
    #     camper.update!(camper_params)
    #     render json: camper
    # end

    # LOL whoops can't just make campers disappear
    # def destroy
    #     camper = find_camper
    #     camper.destroy
    #     render json: 
    # end

    private

    def find_camper
        Camper.find(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end

    def show_errors(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
