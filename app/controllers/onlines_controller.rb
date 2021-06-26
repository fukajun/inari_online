class OnlinesController < ApplicationController
	before_action :authenticate_online!

	def top
		@online = current_online
		iaf = @online.math_iaf
		ias = @online.math_ias
		iibf = @online.math_iibf
		iibs = @online.math_iibs
		iiicf = @online.math_iiicf
		iiics = @online.math_iiics
		if (iaf != 2) && (ias != 2) && (iibf != 2) && (iibs != 2) && (iiicf != 2) && (iiics != 2)
			if iaf == 1
				@online.math_iaf = 2
			elsif ias == 1
				@online.math_ias = 2
			elsif iibf == 1
				@online.math_iibf = 2
			elsif iibs == 1
				@online.math_iibs = 2
			elsif iiicf == 1
				@online.math_iiicf = 2
			elsif iiics == 1
				@online.math_iiics = 2
			end
			@online.update(online_math_params)
		end
	end
	
	def show
		@online = Online.find(params[:id])
		if @online.id != current_online.id
			redirect_to online_path(current_online.id)
		end
	end

	def edit
		@online = Online.find(params[:id])
		if @online.id != current_online.id
			redirect_to online_path(current_online.id)
		end
	end

	def update
		@online = Online.find(params[:id])
		if @online.update(online_params)
			redirect_to online_path(@online)
		else
			render "edit"
		end
	end

	def delete_me
		@online = Online.find(params[:id])
	end

	def withdraw
		@online = Online.find(params[:id])
		@online.status = false
		@online.save
		redirect_to root_path
	end

	private
	def online_params
		params.require(:online).permit(:first_name, :last_name, :kana_name, :parent_name, :gender, :birthday, :school, :grade, :postal_code, :prefecture, :address, :phone, :parent_email)
	end

	def online_math_params
		params.permit(:math_iaf, :math_ias, :math_iibf, :math_iibs, :math_iiicf, :math_iiics)
	end
end
