import 'dart:io';

Future main() async {
  Map<String, String> envVars = Platform.environment;
  // #docregion bind
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    int.parse(envVars['PORT']),
  );
  // #enddocregion bind
  print('Listening on localhost:${server.port}');

  // #docregion listen
  await for (HttpRequest request in server) {
    request.response.write('Hello, world!');
    await request.response.close();
  }
  // #enddocregion listen
}