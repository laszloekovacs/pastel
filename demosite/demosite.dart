import 'package:pastel/pastel.dart';
import 'dart:io';

int refresh = 0;

void view(HttpRequest request) {
  request.response.write("hello from pastel request is: ${request.uri.path}");
}

void viewme(HttpRequest request) {
  request.response.write("me called");
}
void viewmee(HttpRequest request) {
  request.response.write("mee called");
}


void main() {
  Pastel pastel = new Pastel();

  pastel.bind("/", view);
  pastel.bind("/meesa", view);
 
  pastel.bind("/mee", viewmee);
   pastel.bind("/me", viewme);

  pastel.run(port: 8080);
}
