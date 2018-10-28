module Api
	module V1
		class CostsController < ApplicationController
			require 'dijkstra'

			def value
				if params["origin"].present? && params["destination"].present? && params["weight"].present? && request.query_parameters.count == 3
					if validates_weight(params["weight"])
						dijkstra_calc
					else
						render json: {status: 'Error', message:'Weight is invalid', data: params},status: :unprocessable_entity
					end
				else
					render json: {status: 'Error', message:'Amount of parameters are invalid', data: params},status: :unprocessable_entity
				end
			end

			def validates_weight(weight)
				(1..50).include?(weight.to_d)
			end

			def dijkstra_calc
				begin
					r_origin = Distance.pluck(:origin, :destination, :distance)
					r_destination = Distance.pluck(:destination, :origin, :distance)
					ob = Dijkstra.new(params["origin"], params["destination"], r_origin + r_destination)
					if ob.cost.is_a? Numeric
						render plain: (ob.cost * params["weight"].to_d * 0.15).to_s, status: :ok
					end
				rescue
					render json: {status: 'Error', message: 'There is no path between origin and destination', data: params},status: :unprocessable_entity
				end
			end

		end
	end
end
