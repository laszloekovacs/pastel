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
  void bind(String basepath, HttpRequestHandler handler) {
    
    HttpRequestHandler result = null;

    result = pathHandler.putIfAbsent(basepath, () => handler);

    if(result != handler) {
      print("warning: path already bound, skipping ${basepath}");
      return;
    }
    print("bind: path added ${basepath}");
  }

  //
  // call the associated function to the path
  //
  void route(HttpRequest req) {


    if(pathHandler.containsKey(req.uri.pathSegments[0])) {
      pathHandler[req.uri.pathSegments[0]].render(req);
      return;
    } else {
      // handle missing page
    }

     
  }
}