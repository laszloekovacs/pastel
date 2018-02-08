import 'dart:io';
import 'dart:async';

import 'src/HttpRouter.dart';
import 'src/HttpRequestHandler.dart';
import 'src/HttpMime.dart';

export 'src/HttpMime.dart';
export 'src/HttpRouter.dart';
export 'src/HttpRequestHandler.dart';

///
/// The server framework
///
class Pastel {
  HttpServer server = null;
  HttpRouter router = new HttpRouter();

  String serverName = "IBM HAL 9000 running Pastel 0";
  String scriptPath = null;
  String webpath = null;

  ///
  /// handleRequest
  ///
  void _handleRequest(HttpRequest request) {
    router.route(request);

    request.response.flush().then((_) => request.response.close());
  }

  ///
  /// handle errors emmitted by the httpserver
  ///
  void _handleInternalError(var e) {
    print(e.toString());
  }

  ///
  /// Convinience methot exposing the routers binding method
  ///
  void bind(Pattern path, HttpRequestHandler handler) {
    router.bind(path, handler);
  }

  ///
  /// the main entry point of pastel. start serving on an address and port+
  ///
  Future run(
      {var address: "localhost", int port: 80, String webPath: "web"}) async {
    //find the script's directory
    scriptPath = Platform.script.toFilePath();

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
