import 'package:pastel/pastel.dart';
import 'dart:io';



void view(HttpRequest request) {

  request.response.write("hello from pastel request is: ${request.uri.path}, ${refresh++}");
}


void main() {
  Pastel pastel = new Pastel();

  pastel.bind("/", view);

  pastel.run(port: 80);
}
