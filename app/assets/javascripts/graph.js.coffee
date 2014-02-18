class Graph
	constructor: (@containerId, @dataStore, @options) ->
		@init()

	init: ->
		console.log @options	
		@margins =
			top: 30
			right: 60
			bottom: 100
			left: 100
		@xLabel = @options.xLabel
		@yLabel = @options.yLabel


	drawGraph: () ->
		@dataStore.load (data) =>
			@data = data		
			@buildGraph()

	buildGraph: () ->
		nv.addGraph () =>
			chart = nv.models[@graphFunc]().options
				margin: @margins
				x: (d,i) ->
					i

			chart.xAxis
				.axisLabel(@xLabel)
		      	.tickFormat (d) =>
		      		data_element = @data[d]
		      		if data_element
		      			date = data_element.x
		      			d3.time.format('%d/%b')(new Date(date))
		      	.rotateLabels(45)

		    chart.yAxis
		    	.axisLabel(@yLabel)
        		.tickFormat (d) ->
        			'$' + d3.format(',f')(d)

        	$(@containerId).empty()
			d3.select(@containerId).datum(@buildData()).call chart
			nv.utils.windowResize(chart.update)

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
		@graphFunc = "historicalBarChart"
		super

class LineGraph extends Graph
	constructor: (@containerId, @dataStore, @options) ->
		@graphFunc = "lineChart"
		super

window.Maquinet = window.Maquinet || {}
window.Maquinet.BarGraph = window.Maquinet.BarGraph || BarGraph
window.Maquinet.LineGraph = window.Maquinet.LineGraph || LineGraph
