

Meteor.startup ->
	if Players.find().count() is 0
		resetTable()