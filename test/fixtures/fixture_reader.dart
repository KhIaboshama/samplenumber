import 'dart:io';


Future<String> fixture(String name) {
  return Future.value(File('test/fixtures/$name').readAsStringSync());
}