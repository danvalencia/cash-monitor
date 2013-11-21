# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Machine
	constructor: (@id) ->
		@earningsEndpoint = "/machines/#{@id}/earnings"
		@graphsTabName = "#maquinet-graphs"
		@initTabs()

	initTabs: () -> 
		$('#maquinet-tabs a').click (e) =>
			e.preventDefault()
			$(this).tab('show')
			tabName = $(e.target).attr "href"
			if(@graphsTabName == tabName)
				@getEarnings()

	drawGraph: () ->
		console.log "drawGraph"

		nv.addGraph () =>
			chart = nv.models.lineChart().options
					margin:
						left: 100
						bottom: 100
					x: (d,i) ->
						i
					showXAxis: true
					showYAxis: true
					transitionDuration: 250

			chart.xAxis.axisLabel("Sesiones").tickFormat(d3.format(',.1f'))
			chart.yAxis.axisLabel("Ingresos ($)").tickFormat(d3.format(',.2f'))

			d3.select("#earningsGraph svg").datum(@buildData()).call(chart)
			nv.utils.windowResize(chart.update)
			chart.dispatch.on 'stateChange', (e) ->
				nv.log 'New State:', JSON.stringify(e)

	buildData: () ->
		[
			{
				values: @data
				key: "Earnings"
				color: "#FF0000"
			}
		]

	getEarnings: () ->
		$.getJSON @earningsEndpoint, (data) =>
			console.log data
			@data = data
			@drawGraph()

maquinet = new Machine(window.machine_uuid)
