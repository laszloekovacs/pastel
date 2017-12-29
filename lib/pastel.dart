library pastel;

import 'dart:io';
import 'dart:async';

part 'src/router.dart';
part 'src/static.dart';



class Pastel {

  Pastel() {
    requestRouter = new RequestRouter();
    staticServer = new StaticServer();

    basedir = Directory.current;
    print("basepath is ${basedir.toString()}");
  }

  HttpServer server = null;
  RequestRouter requestRouter = null;
  StaticServer staticServer = null;


  Directory basedir;

// use only for debug
  void printRequest(HttpRequest request) {
    print("R - uri:${request.uri} ct:${request.headers.contentType.toString()}");
  }

  /// main entry point when a request arrives
  void handleRequest(HttpRequest request) {
    printRequest(request);
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
    print("Pastel.Dart is listening on ${server.address.host} port: ${server.port}");
  }
}
