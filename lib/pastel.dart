library pastel;

import 'dart:io';
import 'dart:async';

part 'src/router.dart';
part 'src/static.dart';



class Pastel {
  static final Pastel _singleton = new Pastel._internal();

  factory Pastel() {
    return _singleton;
  }

  Pastel._internal() {
    router = new RequestRouter();
  }

  // class member vars
  HttpServer server = null;
  RequestRouter router = null;

  /// main entry point when a request arrives
  void handleRequest(HttpRequest request) {
    // check for static file
    // find the route
    request.response.write("hi");
    request.response.close();
  }

  /// handle errors emmitted by the httpserver
  void handleError(var e) => print(e.toString());

  /// the main entry point of pastel. start serving on an address and port
  Future run(var address, int port) async {
    server = await HttpServer.bind(address, port);


    // bind request and error handlers
    server.listen(handleRequest);
    server.handleError(handleError);

    // show the actual binding
    print("listening on: ${server.address.toString()} , port: ${server.port}");
  }
}
