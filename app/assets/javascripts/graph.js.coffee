#= require d3.v3
#= require nv.d3
#= require axis 
#= require jQDateRangeSlider-min
#= require utils

# Graph 
#
# Base class for all types of graphs.
# You typically would use a subclass of this class and set the @graphType instance variable to the graph type of your choice. 
#
class Graph
  constructor: (@containerId, @dataStore, @options) ->
    @count = 1
    @spinnerSelector = '#spinner'
    @spinnerMarkup = "<div id='spinner'></div>"
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

  drawGraph: (range) =>
    @showSpinner()
    @dataStore.load (data) =>
      if @data        
        @redrawGraph(range)
      else
        @buildGraph()
      @data = data
      @dataSubset = data
      #@hideSpinner()


  redrawGraph: (range) ->
    if range
      @dataSubset = @getDataSubset(range)

    d3.select(@containerId).datum(@buildData()).call @chart
  
  buildGraph: () ->
    nv.addGraph () =>
      @chart = nv.models[@graphType]().options
        margin: @margins
        x: (d,i) ->
          i

      @chart.xAxis
        .axisLabel(@xLabel)
        .tickFormat (d) =>
          dataElement = @dataSubset[d]
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
    data = @dataStore.getData()
    minDate = range[0]
    maxDate = range[1]
    console.log "Range from: #{minDate} to: #{maxDate}"
    filteredData = data.filter (d) ->
      date = new Date(d.x)
      date >= minDate and date <= maxDate

    filteredData
  
  showSpinner: =>
      @container.append(@spinnerMarkup)

  hideSpinner: (element) =>
      $("#{@container} > #{@spinnerSelector}").remove()

# BarGraph
#
# Your typical bar chart
#
class BarGraph extends Graph
  constructor: (@containerId, @dataStore, @options) ->
    @graphType = "discreteBarChart"
    super

# LineGraph
#
# Your typical line chart
#
class LineGraph extends Graph
  constructor: (@containerId, @dataStore, @options) ->
    @graphType = "lineChart"
    super


# MultiViewGraph
# 
# This graph can be used to display different graphs out of the same data.
# For example, you could use this class to visualize the data using a BarGraph and switch to a LineGraph or PieChart.
#
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
    window.onresize = () -> {}
    @currentGraph = @graphs[graphType]     
    @drawGraph()

  drawGraph: () ->
    @container.empty()
    @currentGraph.drawGraph()

  redrawGraph: (range) ->
    @currentGraph.redrawGraph(range)

window.Maquinet = window.Maquinet || {}
window.Maquinet.BarGraph = window.Maquinet.BarGraph || BarGraph
window.Maquinet.LineGraph = window.Maquinet.LineGraph || LineGraph
window.Maquinet.MultiViewGraph = window.Maquinet.MultiViewGraph || MultiViewGraph
