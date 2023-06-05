
import 'dart:io';

Future<String> fixture(String name) {
  return Future.value(File('test/fixtures/$name').readAsStringSync());
}

String fixtureString(String name) {
  return File('test/fixtures/$name').readAsStringSync();
}