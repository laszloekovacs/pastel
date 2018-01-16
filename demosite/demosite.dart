
import 'package:pastel/pastel.dart';
import 'dart:io';

void view(HttpRequest request) {
  request.response.write("hello from pastel");
}


void main() {
  Pastel pastel = new Pastel();

  pastel.bind("/", view);
  pastel.run();
}