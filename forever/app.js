const execSync = require("child_process").execSync;
const express = require('express');
const fs = require('fs');

const procevt = require('./procevt');
const Bot = require('./bot');
const passwd = require('./passwd');
const BotManager = require('./botmanager');

const manager = new BotManager();
const users = new passwd.Passwd();
const USERNAMES = 'catbot-';
const COUNT = 0;
const PORT = 8082;

const app = express();
app.use(express.static(path.join(__dirname, "public")));
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: true }));

// Start polling procfs
procevt.start();

app.get('/list', function(req, res) {
	var result = {};
	result.max = COUNT;
	result.count = count;
	result.bots = {};
	for (var i of bots) {
		result.bots[i.name] = {
			user: i.user
		};
	}
	res.send(result);
});

app.get('/state', function(req, res) {
	var result = {};
	for (var i of bots) {
		result.bots[i.name] = {
			state: i.state,
			started: i.gameStarted
		};
	}
	res.send(result);
});

app.get('/bot/:bot/restart', function(req, res) {

});

app.get('/quota/:quota', function(req, res) {

});

procevt.on('init', () => {
	console.log('procevt init done!');
	users.read(function() {
		var count = 0;
		for (var i in users.users) {
			if (users.users[i].name.indexOf(USERNAME) == 0) {
				if (++count > COUNT) break;
				bots.push(new Bot('bot#' + count, users.users[i]));
			}
		}
	});
});
