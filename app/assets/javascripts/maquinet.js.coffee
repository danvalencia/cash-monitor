#= require router

class Machine
	constructor: (@id) ->
		@earningsEndpoint = "/machines/#{@id}/earnings"
		@sessionsEndpoint = "/machines/#{@id}/sessions"
		@graphsTabName = "#maquinet-graphs"
		@sessionsTabName = "#maquinet-sessions"
		@graphSurfaceSelector = "#earnings-graph svg"
		@earningsSliderSelector = "#earnings-slider"
		@tabsSelector = "#maquinet-tabs a"
		@defaultGraph = "BarGraph"
		@popUpSelector = '.popup-selector'
		@earningsDataStore = new Maquinet.DataStore @earningsEndpoint,
			observer: @graphSurfaceSelector
		@router = new Router
		@init()

	init: () ->

		@router
			.route 'maquinet-graphs', (args) =>
        if $('#maquinet-graphs').hasClass('active')
          $("#earnings-graph-type").html("#{args['graphTitle']}")
          @multiViewGraph.changeGraphType args['graphType']
        else
          $('#maquinet-graphs').tab('show')
        $(@popUpSelector).popover('hide')

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

		$(@sessionsTabName).on 'ajax:success', (event, response, status) ->
			$(this).html(response)

		$(@earningsSliderSelector).on "valuesChanged", (e, data) =>
			@multiViewGraph.redrawGraph([data.values.min, data.values.max])

		$(@popUpSelector).popover
			placement: 'bottom'
			trigger: 'click'
			html: true
			title: 'Tipo de Gráfico'
			content: '<div><a href="#maquinet-graphs;graphType=BarGraph,graphTitle=Barras">Barras</a></div><div><a href="#maquinet-graphs;graphType=LineGraph,graphTitle=Líneas">Líneas</a></div>'

maquinet = new Machine(window.machine_uuid)
$(window).trigger('hashchange')

