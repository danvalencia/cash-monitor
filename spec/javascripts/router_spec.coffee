#= require router

describe 'Router', ->
	router = {}

	beforeEach ->
		router = new Router

	it 'detects simple route', (done) ->
		router.route 'maquinet-graficos', ->
			done()

		window.location.hash = "#maquinet-graficos"

	it 'detects complex route with one var', (done) ->
		router.route 'maquinet-graficos2', (args) ->
			expect(args).toBeTruthy()
			expect(args['g1']).toBe("Bar")
			done()

		window.location.hash = "#maquinet-graficos2;g1=Bar"

	it 'detects complex route with two vars', (done) ->
		router.route 'maquinet-graficos3', (args) ->
			expect(args).toBeTruthy()
			expect(args['g1']).toBe("Bar")
			expect(args['g2']).toBe("Foo")
			done()

		window.location.hash = "#maquinet-graficos3;g1=Bar,g2=Foo"

	# afterEach ->
	# 	window.location.hash = ""
