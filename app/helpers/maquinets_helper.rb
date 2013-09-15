module MaquinetsHelper
	def render_error_messages
  		html_output = ""
 		if @maquinet.errors.any?
  			html_output += "<div id='error_messages'>The following errors where found: <br/><ul>"
  			@maquinet.errors.full_messages.each do |msg|
  				html_output += "<li>#{msg}</li>"
  			end
  			html_output += "</ul></div>"
  		end
		html_output.html_safe
	end
end
