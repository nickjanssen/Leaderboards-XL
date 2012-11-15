

sortFields = ["name","score"]

unless Session.get("currentSortField")?
	Session.set("currentSortField", "score")

unless Session.get("currentSortOrder")?
	Session.set("currentSortOrder", "asc")



Meteor.startup ->
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



Template.leaderboard.players = -> 
	Players.find {}, 
		{sort: [
			[Session.get("currentSortField"), 
				Session.get("currentSortOrder")]
	 	]}

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

Template.player.events 
	"click #remove" : -> 
		Players.remove {@_id}

	"click #love" : ->
		Players.update {_id:@_id}, {$inc: {score: 1}}

Template.newPlayer.events
	"click button" : ->
		newPlayerName = $('#newPlayerName').val()
		if newPlayerName
			Players.insert {name: newPlayerName, score: 0}
			$('#newPlayerName').val("")


				
