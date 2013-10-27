module MaquinetsHelper
	def user_id_for_maquinet(maquinet)
		return maquinet.user.id unless maquinet.user.nil?
	end
end
