
Players = new Meteor.Collection("players")

if Meteor.is_client
	Template.leaderboard.players = Players.find {}, {sort: {score: -1, name: 1}}


	_.extend Template.player,
		events:
			"click #remove" : -> 
				Players.remove {@_id}
