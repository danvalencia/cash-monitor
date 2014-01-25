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
			chart = nv.models.historicalBarChart()
          		.margin
          			top: 30
          			right: 60
          			bottom: 100
          			left: 100
			
			chart.x (d,i) -> 
				i

			chart.xAxis
				.axisLabel("Fecha")
		      	.tickFormat (d) =>
		      		console.log "This is D: #{d}"
		      		data_element = @data[d]
		      		if data_element
		      			date = data_element.x
		      			console.log "Data is #{@data[d]}"
		      			# dx = @data[0].values[d] && @data[0].values[d][0] || 0
		      			d3.time.format('%d/%b')(new Date(date))
		      	.rotateLabels(45)

		    chart.yAxis
		    	.axisLabel("Ingresos ($)")
        		.tickFormat (d) =>
        			console.log "Y Data is: #{d}"
        			'$' + d3.format(',f')(d)

    		# chart.bars.forceY([0]);

			d3.select("#earningsGraph svg").datum(@buildData()).call chart
			nv.utils.windowResize(chart.update)
			#chart.dispatch.on 'stateChange', (e) ->
				#nv.log 'New State:', JSON.stringify(e)

	buildData: () ->
		[
			{
				values: @data
				key: "Ingresos"
				color: "#FF0000"
			}
		]

	getEarnings: () ->
		$.getJSON @earningsEndpoint, (data) =>
			console.log data
			@data = data
			@drawGraph()

maquinet = new Machine(window.machine_uuid)
