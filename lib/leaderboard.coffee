Players = new Meteor.Collection("players")


resetTable = ->
	Players.remove {}
	names = ["Martin Luther King","Michael Jackson","Leonardo Da Vinci",
	"Albert Einstein","Gandhi","William Shakespeare","Abraham Lincoln",
	"Princess Diana"]
	for name in names
		Players.insert {name:name, score: _.random 0, 10}