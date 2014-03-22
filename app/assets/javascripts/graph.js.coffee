class Graph
	constructor: (@containerId, @dataStore, @options) ->
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


	drawGraph: () ->
		@dataStore.load (data) =>
			if @data		
				@redrawGraph()
			else
				@buildGraph()
			@data = data

	redrawGraph: () ->
    	# $(@containerId).empty()
    	console.log "Redrawing Graph"
    	d3.select(@containerId).datum(@buildData()).call @chart
    	# nv.utils.windowResize(@chart.update)
	
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
		      		data_element = @data[d]
		      		if data_element
		      			date = data_element.x
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
				values: @data
				key: @yLabel
				color: "#4DBD33"
			}
		]


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
		@changeViewElement = $(@options.changeViewSelector)
		@graphs = {}
		@init()

	init: () ->
		_.each @graphTypes, (type) =>
			@graphs[type] = new Maquinet[type] @containerId, @dataStore, @options
		@currentGraph = @graphs[@graphTypes[0]] 
		@changeViewElement.change @onViewChange

	onViewChange: (event) =>
		window.onresize = () -> {}
		@currentGraph = @graphs[event.target.value]		
		@drawGraph()

	drawGraph: () ->
		@container.empty()
		@currentGraph.drawGraph()

window.Maquinet = window.Maquinet || {}
window.Maquinet.BarGraph = window.Maquinet.BarGraph || BarGraph
window.Maquinet.LineGraph = window.Maquinet.LineGraph || LineGraph
window.Maquinet.MultiViewGraph = window.Maquinet.MultiViewGraph || MultiViewGraph
