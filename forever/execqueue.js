class ExecQueue {
    constructor(rate) {
        this.rate = 0;
        this.queue = [];
        this.interval = setInterval(this.exec.bind(this), rate);
    }
    exec() {
        (this.queue.shift())();
    }
    push(callback) {
        this.queue.push(callback);
    }
}

module.exports = ExecQueue;
