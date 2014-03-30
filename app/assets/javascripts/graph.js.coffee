class Graph
	constructor: (@containerId, @dataStore, @options) ->
		@count = 1
		@init()

	init: ->
		console.log @options    
		@margins =
			top: 30
			right: 60
			bottom: 100
			left: 60
		@xLabel = @options.xLabel
		@yLabel = @options.yLabel
		@container = $(@containerId)

	drawGraph: (range) ->
		@dataStore.load (data) =>
			if @data        
				@redrawGraph(range)
			else
				@buildGraph()
			@data = data
			@dataSubset = data

	redrawGraph: (range) ->
		if range
			@dataSubset = @getDataSubset(range)

		console.log "Redrawing Graph"
		d3.select(@containerId).datum(@buildData()).call @chart
	
	buildGraph: () ->
		console.log "Building Graph"
		nv.addGraph () =>
			@chart = nv.models[@graphType]().options
				margin: @margins
				x: (d,i) ->
					i

			@chart.xAxis
				.axisLabel(@xLabel)
				.tickFormat (d) =>
					dataElement = @data[d]
					if dataElement
						date = dataElement.x
						d3.time.format('%d/%b')(new Date(date))
				.rotateLabels(45)

			@chart.yAxis
				.axisLabel(@yLabel)
				.tickFormat (d) ->
					'$' + d3.format(',f')(d)

			@chart.forceY 0
			
			d3.select(@containerId).datum(@buildData()).call @chart
			nv.utils.windowResize(@chart.update)

	buildData: () ->
		[
			{
				values: @dataSubset
				key: @yLabel
				color: "#4DBD33"
			}
		]

	getDataSubset: (range) ->
		console.log "Data Subset Range: #{range}"
		console.log "The Data -> #{@dataStore.getData()}"
		data = @dataStore.getData()
		minDate = range[0]
		maxDate = range[1]
		filteredData = data.filter (d) ->
			date = new Date(d.x)
			date >= minDate and date <= maxDate

		filteredData

class BarGraph extends Graph
	constructor: (@containerId, @dataStore, @options) ->
		@graphType = "discreteBarChart"
		super

class LineGraph extends Graph
	constructor: (@containerId, @dataStore, @options) ->
		@graphType = "lineChart"
		super

class MultiViewGraph extends Graph
	constructor: (@containerId, @dataStore, @options) ->
		@container = $(@containerId)
		@graphTypes = @options.graphTypes
		@graphs = {}
		@init()

	init: () ->
		for type in @graphTypes
			@graphs[type] = new Maquinet[type] @containerId, @dataStore, @options
		@currentGraph = @graphs[@graphTypes[0]] 

	changeGraphType: (graphType) ->
		console.log "Changing graph type again"
		window.onresize = () -> {}
		@currentGraph = @graphs[graphType]     
		@drawGraph()

	drawGraph: () ->
		@container.empty()
		@currentGraph.drawGraph()

window.Maquinet = window.Maquinet || {}
window.Maquinet.BarGraph = window.Maquinet.BarGraph || BarGraph
window.Maquinet.LineGraph = window.Maquinet.LineGraph || LineGraph
window.Maquinet.MultiViewGraph = window.Maquinet.MultiViewGraph || MultiViewGraph
