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

		_this = this


		# @changeViewSelector.change () ->
		# 	console.log "This value: #{this.value}"
			
		# 	graph = new Maquinet[this.value] "#earnings-graph svg", _this.dataStore, 
		# 		xLabel: "Fecha"
		# 		yLabel: "Ingresos"
		# 	graph.drawGraph()



		# 	console.log "Graph type changed to #{this.value}"





maquinet = new Machine(window.machine_uuid)
