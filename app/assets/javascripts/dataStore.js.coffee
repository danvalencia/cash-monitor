class DataStore
	constructor: (@url, options) ->
		{@observer} = options

	load: (callback) ->
		if @data
			callback @data	
		else
			$.getJSON @url, (data) =>
				@data = data
				$(@observer).trigger "cashmonitor.graphDataLoaded", [data]
				callback @data

	getData: ->
		@data



window.Maquinet = window.Maquinet || {}
window.Maquinet.DataStore = window.Maquinet.DataStore || DataStore
