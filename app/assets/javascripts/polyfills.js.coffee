unless Array::filter
	Array::filter = (callback) ->
		element for element in this when callback(element)

