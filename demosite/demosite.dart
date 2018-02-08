import 'package:pastel/pastel.dart';
import 'package:pastel/src/HttpRequestHandler.dart';
import 'dart:io';

int refresh = 0;

class rootHandler implements HttpRequestHandler {
  @override
  void render(HttpRequest req) {
    req.response.headers.contentType = ContentType.HTML; 
    req.response.write("hello from pastel request is: ${req.uri.path}, ${refresh++}");
  }
}

void main() {
  Pastel pastel = new Pastel();

  pastel.router.bind(r"/", new rootHandler());
  pastel.router.bind(r"/web", new HttpStaticRequestHandler());

  pastel.run(port: 80);
}
