import 'package:flutter/material.dart';
import 'package:vidio_player/screens/homepage.dart';
import 'package:vidio_player/screens/videos.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'video page': (context) => VideoPage(),
      },
    ),
  );
}
