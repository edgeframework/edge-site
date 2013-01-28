var vertx = require('vertx.js');
var fs = vertx.fileSystem;

var server = vertx.createHttpServer();

server.requestHandler(function(req) {
	var file = '';

	if (req.path.indexOf('..') > -1) {
		req.send("error");
	}

	// Path ends with /
	if (req.path.match('/$')) {
		file = '.' + req.path + "index.html";
	}else{
		file = '.' + req.path + ".html";
	}

	fs.exists(file, function(err,exists){
		console.log(req.path + " => " + file);

		if(err || !exists){
			// File does not exist
			req.response.end("Resource not found");
			return;
		}

		req.response.sendFile(file);
	});


}).listen(8080, 'localhost');

console.log("Test Server Launched");