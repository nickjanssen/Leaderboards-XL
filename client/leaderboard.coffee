
# A list of fields we'll be using inside our coffee file
# Note that you need to manually add fields to the HTML template yourself
sortFields = ["name","score"]

#If we don't have any sorting fields or orders set, set them to a default value
unless Session.get("currentSortField")?
	Session.set("currentSortField", "score")

unless Session.get("currentSortOrder")?
	Session.set("currentSortOrder", "desc")


# The autorun function is reactive and will automatically re-run whenever the
# Session variables inside are updated
# It is put within Meteor's startup function to make sure it doesn't update the
# sort buttons before they are loaded. In a way, this works like jQuery's 
# startup function, but Meteor will wait until the DOM is ready and any <body> 
# templates from your .html files have been put on the screen.
Meteor startup ->
	Meteor.autorun ->
		for field in sortFields		
			$("##{field}Sort i:first-child")
				.removeClass("icon-chevron-up icon-chevron-down")
			
			if Session.get("currentSortField") is field
				if Session.get("currentSortOrder") is "asc"
					$("##{field}Sort i:first-child")
						.addClass("icon-chevron-up")
				else 
					$("##{field}Sort i:first-child")
						.addClass("icon-chevron-down")


# The mongoDB 'players' is reactive and will auto update itself whenever
# the Session variables inside have changed
Template.leaderboard.players = -> 
	Players.find {}, 
		{sort: [
			[Session.get("currentSortField"), 
				Session.get("currentSortOrder")]
	 	]}

# Check every field and assign an event to change the sort orders/fields
# whenever we pressed the corresponding button from the HTML file
for field in sortFields
	do (field) ->
		events = {}
		events["click ##{field}Sort"] = -> 
			if Session.get("currentSortField") is field
				if Session.get("currentSortOrder") is "asc"
					newSortOrder = "desc"
				else
					newSortOrder = "asc"
				Session.set("currentSortOrder", newSortOrder)
			else
				Session.set("currentSortField", field)
				Session.set("currentSortOrder", "asc")

		Template.leaderboard.events events

# Events for removing and loving players
Template.player.events 
	"click #remove" : -> 
		Players.remove {@_id}

	"click #love" : ->
		Players.update {_id:@_id}, {$inc: {score: 1}}

# Events for adding new players and resetting the table
Template.lbActions.events
	"click #addPlayer" : ->
		newPlayerName = $('#newPlayerName').val()
		if newPlayerName
			Players.insert {name: newPlayerName, score: 0}
			$('#newPlayerName').val("")
	"click #resetTable" : ->
		Players.remove {}
		names = ["Martin Luther King","Michael Jackson","Leonardo Da Vinci",
		"Albert Einstein","Gandhi","William Shakespeare","Abraham Lincoln",
		"Princess Diana"]
		for name in names
			Players.insert {name:name, score: _.random 0, 10}



				
