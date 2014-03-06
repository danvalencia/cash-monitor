class Machine
	constructor: (@id) ->
		@earningsEndpoint = "/machines/#{@id}/earnings"
		@sessionsEndpoint = "/machines/#{@id}/sessions"
		@graphsTabName = "#maquinet-graphs"
		@sessionsTabName = "#maquinet-sessions"
		@changeViewSelector = "#earnings-graph .graph-type"
		@graphSurfaceSelector = "#earnings-graph svg"
		@defaultGraph = "BarGraph"
		@earningsDataStore = new Maquinet.DataStore(@earningsEndpoint)
		@init()

	init: () ->
		$('#maquinet-tabs a').on 'shown', (e) =>
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

maquinet = new Machine(window.machine_uuid)
