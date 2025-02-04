import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'Route/BaseRoute.dart';

void main() {
  withHotreload(
    () => createServer(),
    logLevel: Level.INFO,
  );
}

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;
  final pipline = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(BaseRoute().myBaseRoute);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(pipline, ip, port);
  print('Server listening on port ${server.port}');

  return server;
}
