class Machine
	constructor: (@id) ->
		@earningsEndpoint = "/machines/#{@id}/earnings"
		@graphsTabName = "#maquinet-graphs"
		@graphTypeSelector = $("#earnings-graph .graph-type")
		@defaultGraph = "BarGraph"
		@dataStore = new Maquinet.DataStore(@earningsEndpoint)
		@init()

	init: () -> 
		$('#maquinet-tabs a').click (e) =>
			e.preventDefault()
			$(this).tab('show')
			tabName = $(e.target).attr "href"
			if(@graphsTabName == tabName)
				console.log "About to instantiate defaultGraph"
				defaultGraph = new Maquinet[@defaultGraph] "#earnings-graph svg", @dataStore, 
					xLabel: "Fecha"
					yLabel: "Ingresos"
				defaultGraph.drawGraph()

		_this = this
		@graphTypeSelector.change () ->
			console.log "This value: #{this.value}"
			
			graph = new Maquinet[this.value] "#earnings-graph svg", _this.dataStore, 
				xLabel: "Fecha"
				yLabel: "Ingresos"
			graph.drawGraph()



			console.log "Graph type changed to #{this.value}"





maquinet = new Machine(window.machine_uuid)
