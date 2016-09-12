// compile YourApp.elm with:
//		elm make YourApp.elm --output elm.js

// load Elm module
const elm = require('./elm.js');

// get Elm ports
const ports = elm.Test.App.worker().ports;

// keep our app alive until we get an exitCode from Elm or SIGINT or SIGTERM (see below)
setInterval(id => id, 86400);

ports.node.subscribe(exitCode => {
	console.log('Exit code from Elm:', exitCode);
	process.exit(exitCode);
});

process.on('uncaughtException', err => {
	console.log(`Uncaught exception:\n`, err);
	process.exit(1);
});

process.on('SIGINT', _ => {
	console.log(`SIGINT received.`);
	process.exit(0);
});

process.on('SIGTERM', _ => {
	console.log(`SIGTERM received.`);
	process.exit(0);
});
