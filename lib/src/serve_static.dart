part of pastel;

// serving static files

Future serveStatic(HttpRequest request) async {
  
  if (request.method == "GET") {
    String path = " ${settings["context_path"]}${request.uri}"; 
    
    File file = new File("${path}index.html");

    if (file.existsSync()) {
      await file.openRead().pipe(request.response);
    }
  }
}
