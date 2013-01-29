var vertx = require('vertx.js');
var fs = vertx.fileSystem;

var server = vertx.createHttpServer();

function serveFile(req, file){
  fs.exists(file, function(err,exists){
    if(err || !exists){
      file = file + '.html';
    }

    console.log(req.path + " => " + file);

    req.response.sendFile(file);
  });
}

server.requestHandler(function(req) {
  var file = '';

  if (req.path.indexOf('..') > -1) {
    req.send("error");
  }

  // Path ends with /
  if (req.path.match('/$')) {
    file = '.' + req.path + "index.html";
  } else {
    file = '.' + req.path;
  }

  serveFile(req, file);


}).listen(8080, 'localhost');

console.log("Test Server Launched");