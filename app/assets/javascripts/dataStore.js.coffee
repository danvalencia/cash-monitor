class DataStore
	constructor: (@url) ->
		console.log "Inside DataStore"

	load: (callback) ->
		console.log "Data source url is #{@url}"
		if @data
			callback @data	
		else
			$.getJSON @url, (data) =>
				@data = data
				callback @data

window.Maquinet = window.Maquinet || {}
window.Maquinet.DataStore = window.Maquinet.DataStore || DataStore
