
import 'package:pastel/pastel.dart';
import 'dart:io';

int refresh = 0;

void view(HttpRequest request) {
  request.response.write("hello from pastel refresh is: $refresh");
  refresh++;
  
  Cookie pie = new Cookie("sesh", "223");
  pie.httpOnly = false;


  request.response.cookies.add(pie);
}


void main() {
  Pastel pastel = new Pastel();

  pastel.bind("/", view);
  pastel.run();
}