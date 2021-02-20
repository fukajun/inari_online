class OnlinesController < ApplicationController
	before_action :authenticate_online!

	def top
		@subject = Subject.find_by(online_id: current_online.id)
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
		params.require(:online).permit(:first_name, :last_name, :kana_name, :parent_name, :gender, :birthday, :school, :grade, :postal_code, :prefecture, :address, :phone, :parent_email, :subject)
	end
end
