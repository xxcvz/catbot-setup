const procevt = require('./procevt');
const passwd = require('./passwd');
const Bot = require('./bot');

const users = new passwd.Passwd();

class BotManager {
    constructor() {
        var self = this;
        this.bots = [];
        this.quota = 0;
        procevt.once('update', function() {
            procevt.on('birth', self.onProcBirth.bind(self));
            procevt.on('death', self.onProcDeath.bind(self));
        });
    }
    freeUser() {
        users.readSync();
        var nonfree = {};
        for (var bot of this.bots) {
            nonfree[bot.user.uid] = true;
        }
        for (var uid in users.users) {
            if (!nonfree[uid]) return users.users[uid];
        }
        return null;
    }
    onProcBirth(proc) {
        if (proc.name == 'hl2_linux') {
            for (var bot of this.bots) {
                if (proc.uid == bot.user.uid) {
                    bot.onGameBirth(proc);
                }
            }
        }
    }
    onProcDeath(proc) {
        if (proc.name == 'hl2_linux') {
            for (var bot of this.bots) {
                if (proc.uid == bot.user.uid) {
                    bot.onGameDeath(proc);
                }
            }
        }
    }
    enforceQuota() {
        var quota = this.quota;
        var actual = this.bots.length;
        while (this.bots.length < quota) {
            var u = this.freeUser();
            if (!u) {
                console.log('[ERROR] Could not allocate user for bot!');
                return;
            }
            this.bots.push(new Bot(u));
        }
        while (this.bots.length > quota) {
            var b = this.bots.pop();
            b.stop();
        }
    }
    bot(name) {
        for (var bot of bots) {
            if (bot.name == name) return bot;
        }
        return null;
    }
    setQuota(quota) {
        this.quota = parseInt(quota);
        this.enforceQuota();
    }
    getJSONStatus() {
        var result = {};
        return result;
    }
}

module.exports = BotManager;
