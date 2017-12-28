library pastel;

import 'dart:io';
import 'dart:async';

part 'src/router.dart';

/// Pastel singleton class
class Pastel {
  static final Pastel _singleton = new Pastel._internal();

  factory Pastel() {
    return _singleton;
  }

  // internal constructor for singleton spawning
  Pastel._internal();

  void handleRequest(HttpRequest request) {}
  void handleError(var e) => print(e.toString());

  /// start serving on a address and port
  void run(var address, int port) async {
    HttpServer server = await HttpServer.bind(address, port);
    server.listen(handleRequest);
    server.handleError(handleError);
  }
}