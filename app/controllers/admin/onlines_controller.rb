class Admin::OnlinesController < ApplicationController
	before_action :authenticate_admin!
	
	def index
		@q = Online.ransack(params[:q])
		if params[:AllStudent]
			@onlines = @q.result(distinct: true)
		else
			@onlines = @q.result(distinct: true).where(status: true)
		end

		# 受講生数
		@AllStudent = Online.where(status: true).count
		@mathIAF = Online.where(course: 1, status: true).count
		@mathIAS = Online.where(course: 2, status: true).count
		@mathIIBF = Online.where(course: 3, status: true).count
		@mathIIBS = Online.where(course: 4, status: true).count
		@mathIIICF = Online.where(course: 5, status: true).count
		@mathIIICS = Online.where(course: 6, status: true).count
	end

	def show
		@online = Online.find(params[:id])
		@studies = Study.where(online_id: @online.id)
	end

	def edit
		@online = Online.find(params[:id])
	end

	def update
		@online = Online.find(params[:id])
		@studies = Study.where(online_id: @online.id)
		if @online.update(online_params)
			render "show", notice: "successfully updated!"
		else
			render "edit"
		end
	end

	private
	def online_params
		params.require(:online).permit(:first_name, :last_name, :kana_name, :parent_name, :gender, :birthday, :high_school, :junior_high_school, :elementary_school, :grade, :postal_code, :prefecture, :address, :phone, :parent_email, :subject, :status, :note)
	end
end
