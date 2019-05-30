import 'dart:io';

String host =getHost();
String getHost() => (Platform.isAndroid)? '10.0.2.2' : 'localhost';