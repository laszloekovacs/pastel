import "dart:io";
import 'HttpRequestHandler.dart';

///
/// route requests to the proper responder
///

class HttpRouter {

  // a map that holds the path and the handler
  Map <Pattern, HttpRequestHandler> pathHandler = new Map();

  //
  // Every base path is bound to a request handler
  //
  void bind(Pattern pattern, HttpRequestHandler handler) {
    
    HttpRequestHandler result = null;

    result = pathHandler.putIfAbsent(pattern, () => handler);

    if(result != handler) {
      print("warning: path already bound, skipping ${pattern}");
      return;
    }
    print("bind: path added ${pattern}");
  }

  ///
  /// call the associated function to the path
  /// the router only checks the first segment of the path.
  /// request handlers have to deal with the other segments
  /// 
  void route(HttpRequest req) {

    print("route: requested ${req.uri.path}");

    var key = r"/";

    if(req.uri.pathSegments.isEmpty) {
      key = r"/";
    } else {
      key = r"/" + req.uri.pathSegments.first;
    }
  

    if(pathHandler.containsKey(key)) {
      pathHandler[key].render(req);
      return;
    } else {
      // handle missing page
      req.response.write("not found");
    }
  }
}