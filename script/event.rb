@now = Time.now.strftime("%Y-%m-%d %H:%M:%S.%3N")
EVENTS_FILE = "/opt/cash-monitor/files/events.txt"

module Event

	def create_session
		write_event "sesion_creada,#{@now}"
	end

	def coin_insert(count)
		write_event "moneda_insertada,#{@now},#{count}"
	end

	def counter_reset()
		write_event "contador_reseteado,#{@now}"
	end

	def update_config(coin_value, coin_count)
		write_event "configuracion_actualizada,#{@now},#{coin_value},#{coin_count}"
	end

	def close_session
		write_event "sesion_cerrada,#{@now}"
	end

	def usage
		write_event "event.rb <event_name> [<arg1>...<argn>]"
	end

	def write_event event_str
		puts event_str
		File.open(EVENTS_FILE, "w+") do |f|
			f.puts event_str
		end
	end

end

# if ARGV.length > 0
# 	command_name = ARGV.shift
# 	command_args = ARGV.join(",")
# 	command_str = eval "#{command_name}(#{command_args})"
# 	system "echo #{command_str} | tee -a #{EVENTS_FILE}"
# else
# 	usage
# end
