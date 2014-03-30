class Machine
	constructor: (@id) ->
		@earningsEndpoint = "/machines/#{@id}/earnings"
		@sessionsEndpoint = "/machines/#{@id}/sessions"
		@graphsTabName = "#maquinet-graphs"
		@sessionsTabName = "#maquinet-sessions"
		@changeViewSelector = "#earnings-graph .graph-type"
		@graphSurfaceSelector = "#earnings-graph svg"
		@earningsSliderSelector = "#earnings-slider"
		@tabsSelector = "#maquinet-tabs a"
		@defaultGraph = "BarGraph"
		@earningsDataStore = new Maquinet.DataStore @earningsEndpoint,
			observer: @graphSurfaceSelector

		@init()

	init: () ->
		$(@graphSurfaceSelector).on 'cashmonitor.graphDataLoaded', (e, data) =>
			for daysEarnings in data
				console.log "x: #{daysEarnings.x}, y: #{daysEarnings.y}"
			minDate = new Date(data[0].x)
			maxDate = new Date(data[data.length-1].x)

			$(@earningsSliderSelector).dateRangeSlider 
				bounds: 
					min: minDate
					max: maxDate
				defaultValues:
					min: minDate
					max: maxDate
				step:
					days: 1

		$(@tabsSelector).on 'shown', (e) =>
			e.preventDefault()
			$(this).tab('show')
			tabName = $(e.target).attr "href"
			switch tabName
				when @graphsTabName
					@multiViewGraph = new Maquinet.MultiViewGraph @graphSurfaceSelector, @earningsDataStore,
						graphTypes: ["BarGraph", "LineGraph"]
						changeViewSelector: @changeViewSelector
						xLabel: "Fecha"
						yLabel: "Ingresos"
					@multiViewGraph.drawGraph()
				when @sessionsTabName
					$.ajax
						url: @sessionsEndpoint
						success: (data, status, xhr) =>
							$(@sessionsTabName).html(xhr.responseText)
					# alert 'sessions!'

		$(@sessionsTabName).on 'ajax:success', (event, response, status) ->
			$(this).html(response)

		$(@changeViewSelector).on 'change', (event) =>
			@multiViewGraph.changeGraphType event.target.value

		$(@earningsSliderSelector).on "valuesChanged", (e, data) =>
			console.log "Values have changed. min: #{data.values.min}, max: #{data.values.max}"
			console.log @multiViewGraph
			@multiViewGraph.redrawGraph([data.values.min, data.values.max])

maquinet = new Machine(window.machine_uuid)
