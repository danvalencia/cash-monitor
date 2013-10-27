# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Maquinet =
	initTabs: () -> 
		$('#maquinet-tabs a').click (e) ->
			e.preventDefault()
			$(this).tab('show')
			console.log("Related target: " + e.relatedTarget)
			console.log("Target: " + e.target)
			# $(e.relatedTarget).hide();	
			# $(e.target).show();	

Maquinet.initTabs()