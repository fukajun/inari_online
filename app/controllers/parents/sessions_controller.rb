class Parents::SessionsController < ApplicationController
	def new
	end

	def create
		parent = Online.find_by!(membership_number: session_params[:membership_number])
		if parent.parent_email == session_params[:parent_email]
			parent_sign_in parent
			redirect_to reports_path
		else
			render 'new'
		end
	end

	def destroy
		parent_sign_out
		redirect_to new_parent_session_path
	end

	private
	def session_params
		params.require(:session).permit(:membership_number, :parent_email)
	end
end
