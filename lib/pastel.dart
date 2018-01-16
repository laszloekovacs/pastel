library pastel;

import 'dart:io';
import 'dart:async';

typedef void ViewHandler(HttpRequest request);

// mime types
Map mimetype = {
  "htm": "text/html", 
  "html": "text/html",
  "css" : "text/css",
  "jpg": "image/jpeg"
  };

///
/// The server framework
///
class Pastel {
  HttpServer server;
  String serverName = "IBM HAL 9000 running Pastel 0";
  String contentPath;
  String basePath;

  /// registered routes used by the server
  Map<Pattern, ViewHandler> routes = new Map();

  /// mime type lookup helper
  String _findMime(String path) {
    List parts = path.split(".");

    // the last part will be the file extension, check if we have it
    if (mimetype.containsKey(parts.last)) {
      return mimetype[parts.last];
    } else {
      print("warning: unknown mime type: ${parts.last}");
      return "text/plain";
    }
  }

  /// bind a pattern to a view handler
  /// reject overwrites
  void bind(Pattern path, ViewHandler handler) {
    if (routes.containsKey(path)) {
      print("warning: path allready registered: $path");
    } else {
      routes.addAll({path: handler});
      print("ok: path bound: $path");
    }
  }

  /// helper function, calls route func on key
  void _callView(Pattern key, HttpRequest r) => routes[key](r);

  ///
  /// handleRequest
  ///
  void _handleRequest(HttpRequest request) {
    String req = request.uri.toString();

    // try serving as a static file
    if (FileSystemEntity.isFileSync(contentPath + req)) {
      File reqFile = new File(contentPath + req);

      // write the mime type into the header
      String mime = _findMime(reqFile.path);

      // split the mime into two
      var mimePair = mime.split("/");
      ContentType content = new ContentType(mimePair.first, mimePair.last);
      request.response.headers.contentType = content;
      

      // headers must be written before the body
      if(mimePair.first == "text") {
        request.response.write(reqFile.readAsStringSync());
      } else {
        request.response.add(reqFile.readAsBytesSync());
      }
      
    }
    // call view if we have a match
    else if (routes.containsKey(req)) {
      _callView(req, request);
    }

    // should show an error page
   request.response.flush().then((_) => request.response.close());
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
    contentPath = "${basePath.toString()}${webPath}";

    print("basePath is: $basePath");
    print("contentPath is: $contentPath");

    // start actually listening to the requests
    server = await HttpServer.bind(address, port);

    // change the server header to something more fun
    server.serverHeader = serverName;
    //server.autoCompress = true;

    // bind request and error handlers
    server.handleError(_handleInternalError);
    server.listen(_handleRequest);

    // show the actual binding
    print("listening on: ${server.address} , port: ${server.port}");
  }
}
