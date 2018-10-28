module Api
	module V1
		class DistancesController < ApplicationController

      def create
				if request.raw_post.present?
					if request.raw_post.split.count != 3
						render json: {status: 'Error', message:'Amount of parameters are invalid', data: request.raw_post},status: :unprocessable_entity
					else
		        distance_formated_params = format_params(request.raw_post)
						if Distance.where(
							origin: distance_formated_params["origin"], destination: distance_formated_params["destination"])
							.update_or_create(origin: distance_formated_params["origin"],
								 								destination: distance_formated_params["destination"],
																distance: distance_formated_params["distance"])
							render json: {status: 'Success', message:'Distance created or updated with success', data: distance_formated_params},status: :ok
						else
							render json: {status: 'Error', message:'Some params are invalid', data: request.raw_post},status: :unprocessable_entity
						end
					end
				else
					render json: {status: 'Error', message:'There are no params', data: request.raw_post},status: :unprocessable_entity
				end
      end

			def format_params(params)
				returning_params = Hash.new(0)
				returning_params["origin"] = params.split[0]
				returning_params["destination"] = params.split[1]
				returning_params["distance"] = params.split[2].try(:to_d)
				return returning_params
			end

		end
	end
end
