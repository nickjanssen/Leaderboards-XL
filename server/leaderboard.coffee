
#reset scoreoard
resetTable = ->
	Players.remove({})
	
	names = [
		"Ada Lovelace",		
		"Grace Hopper",
		"Marie Curie",
		"Carl Friedrich Gauss",
		"Nikola Tesla",
		"Gavin Payne"
		]
		
	Players.insert(name: item, score: _.random(1,1000)) for item in names
	