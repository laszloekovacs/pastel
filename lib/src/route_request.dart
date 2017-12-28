part of pastel;



// routing handler
void routeRequest(HttpRequest request) {

  // try to serve a static file 
  serveStatic(request);
}
