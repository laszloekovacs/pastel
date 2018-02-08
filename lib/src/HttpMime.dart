import 'dart:io';


class HttpMime {
  
  ///
  /// using the file name extension, return the mime type of the requested file
  ///
  static ContentType get(String filename) {
    List path = filename.split(".");

   
    switch (path.last) {
      case "css":
        return new ContentType("text", "css");

      case "jpeg":
      case "jpg":
        return new ContentType("image", "jpeg");

      case "html":
      case "htm":
        return new ContentType("text", "html");

      case "png":
        return new ContentType("image", "png");

      case "js":
        return new ContentType("application", "javascript");

      case "json":
        return new ContentType("application", "json");

      case "ico":
        return new ContentType("image", "x-icon");

      default:
        print("Warning: ${path.last} extension`s mime type not known, sending as text/plain");
        return new ContentType("text", "plain");
    }
  }
}
