library pastel;

import 'dart:io';
import 'dart:async';

part 'src/common.dart';
part 'src/route_request.dart';
part 'src/serve_static.dart';

HttpServer server;

/// main entry point when a request arrives
void handleRequest(HttpRequest request) {
  // check for static file
  // find the route
  request.response.write("hi");
  request.response.close();
  print(server.connectionsInfo().total);
}

/// handle errors emmitted by the httpserver
void handleError(var e) => print(e.toString());

/// the main entry point of pastel. start serving on an address and port
Future run(var address, int port) async {
  server = await HttpServer.bind(address, port);

  // change the server header to something more fun
  server.serverHeader = defaults["serverheader"];

  // bind request and error handlers
  server.listen(handleRequest);
  server.handleError(handleError);

  // show the actual binding
  print("listening on: ${server.address} , port: ${server.port}");
}
