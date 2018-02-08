import 'dart:io';

abstract class HttpRequestHandler {
  void render(HttpRequest req);
}

///
/// Serve static files from hdd
///
class HttpStaticRequestHandler implements HttpRequestHandler {
  Uri path;

  HttpStaticRequestHandler(Uri basepath) {
    path = basepath ;
  }

  ///
  /// return the file requested
  ///
  void render(HttpRequest req) {
    String sp = Platform.script.path;

    var p = req.uri.resolve(sp);
    print(p.toString());

    req.response.write("hali");
  }
}
