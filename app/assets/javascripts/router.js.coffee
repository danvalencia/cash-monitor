class Router
	constructor: () ->
		@routeTable = {}
		@initialize()

	initialize: () ->
		$(window).on 'hashchange', =>
			strippedHash = window.location.hash.substring 1
			handler = @routeTable[strippedHash]
			handler() if handler

	route: (path, handler) ->
		@routeTable[path] = handler
		return @

window.Router ||= Router