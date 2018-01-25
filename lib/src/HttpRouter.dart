
import 'dart:io';

///
/// route requests to the proper responder
///
class HttpRouter {
  Map<Uri, dynamic> paths;

//
// associate a uri to a responder
//
  void addPath(Uri uri, var handler) {
    var result = null;

    result = paths.putIfAbsent(uri, () => handler);

    if (result != handler) {
      print("warning: path already being handled ${uri.toString()}");
    }
  }

  void route(HttpRequest req) {}
}
