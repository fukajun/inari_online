module Parents::SessionsHelper
	def parent_sign_in(parent)
		session[:parent_id] = parent.id
	end

	def current_parent
		@current_parent ||= Online.find_by(id: session[:parent_id])
	end

	def parent_signed_in?
		!current_parent.nil?
	end

	def parent_sign_out
		session.delete(:parent_id)
		@current_parent = nil
	end
end
