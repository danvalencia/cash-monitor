module ApplicationHelper

	def render_error_messages_for(model)
  		html_output = ""
 		if model.errors.any?
  			html_output += "<div id='error_messages'>The following errors where found: <br/><ul>"
  			model.errors.full_messages.each do |msg|
  				html_output += "<li>#{msg}</li>"
  			end
  			html_output += "</ul></div>"
  		end
		html_output.html_safe
	end
	
  def print_machine_user(machine)
    if(machine.user.nil?)
      "N/A"
    else
      "#{machine.user.first_name} #{machine.user.last_name}"
    end
  end

  def users_for_select
    User.find(:all).map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
  end

  def format_date(date, format = '%d/%m/%y %k:%M:%S')
    date.strftime format unless date.nil?
  end
end
