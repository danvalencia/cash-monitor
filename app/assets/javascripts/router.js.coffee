class Router
	constructor: () ->
		@routeTable = {}
		@initialize()

	initialize: () ->
		$(window).on 'hashchange', =>
			strippedHashRoute = window.location.hash.substring 1
			tokenizedRoute = strippedHashRoute.split(/;/)
			handlerName = @extractHandlerName strippedHashRoute
			args = @extractArgs tokenizedRoute
			handler = @routeTable[handlerName]
			handler(args) if handler

	route: (path, handler) ->
		handlerName = @extractHandlerName path
		@routeTable[handlerName] = handler
		return @

	extractHandlerName: (routeStr) ->
		return routeStr.split(/;/)[0]

	extractArgs: (tokenizedStr) ->
		argumentsObject = {}
		if tokenizedStr.length > 1
			argsStr = tokenizedStr[1]
			tokenizedArgs = argsStr.split ','
			for arg in tokenizedArgs
				tokenizedArg = arg.split '='
				if tokenizedArg.length > 1
					argumentsObject[tokenizedArg[0]] = tokenizedArg[1]

		return argumentsObject


window.Router ||= Router