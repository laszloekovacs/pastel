library pastel;

import 'dart:io';
import 'dart:async';



typedef void ViewHandler(var request);


// mime types
var mimetype = {
  ".css": "text/css",
  ".htm": "text/html",
  ".html": "text/html",
  ".ico": "image/x-icon",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg"
};



///
/// The server framework
///
class Pastel {
  HttpServer server;
  String serverName = r"Pastel.dart milestone 0 on Peace Walker";
  String contentPath;
  String basePath;

/// registered routes used by the server
  Map<String, ViewHandler> routes = new Map();

/// bind a pattern to a view handler
  void bind(String path, ViewHandler handler) {

    routes.putIfAbsent(path, () => handler);
    print("path bound: $path");
  }

  ///
  /// handleRequest
  ///
  void _handleRequest(HttpRequest request) {
    
    String key = request.uri.toString();

    if(routes.containsKey(key) == true) {
      print("found key: $key");
      routes[key](request);
    }

    request.response.close();
  }

  ///
  /// handle errors emmitted by the httpserver
  ///
  void _handleInternalError(var e) {
    print(e.toString());
  }

  ///
  /// the main entry point of pastel. start serving on an address and port+
  ///
  Future run(
      {var address: "localhost", int port: 80, String webPath: "web"}) async {
    //find the script's directory
    var fpath = Platform.script.toFilePath();
    var script = Platform.script.pathSegments.last;

    basePath = fpath.substring(0, fpath.length - script.length);
    contentPath = "${basePath.toString()}${webPath}\\";

    print("basePath is: $basePath");
    print("contentPath is: $contentPath");

    // start actually listening to the requests
    server = await HttpServer.bind(address, port);

    // change the server header to something more fun
    server.serverHeader = serverName;
    server.autoCompress = true;

    // bind request and error handlers
    server.handleError(_handleInternalError);
    server.listen(_handleRequest);

    // show the actual binding
    print("listening on: ${server.address} , port: ${server.port}");
  }
}
