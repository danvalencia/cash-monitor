class Machine
	constructor: (@id) ->
		@earningsEndpoint = "/machines/#{@id}/earnings"
		@graphsTabName = "#maquinet-graphs"
		@changeViewSelector = "#earnings-graph .graph-type"
		@graphSurfaceSelector = "#earnings-graph svg"
		@defaultGraph = "BarGraph"
		@dataStore = new Maquinet.DataStore(@earningsEndpoint)
		@init()

	init: () -> 
		$('#maquinet-tabs a').click (e) =>
			e.preventDefault()
			$(this).tab('show')
			tabName = $(e.target).attr "href"
			if(@graphsTabName == tabName)
				@multiViewGraph = new Maquinet.MultiViewGraph @graphSurfaceSelector, @dataStore,
					graphTypes: ["BarGraph", "LineGraph"]
					changeViewSelector: @changeViewSelector
					xLabel: "Fecha"
					yLabel: "Ingresos"
				@multiViewGraph.drawGraph()

maquinet = new Machine(window.machine_uuid)
