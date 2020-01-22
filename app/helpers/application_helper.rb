module ApplicationHelper

	def current_order
		if !session[:order_id].nil?
			Order.find(session[:order_id])
		else
			if user_signed_in?
				order = Order.create(user_id: current_user.id)
				session[:order_id] = order.id
				order
			end
		end
	end

	def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
	end
	
end
