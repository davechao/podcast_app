import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:podcastapp/app.dart';

void main() {
  Stetho.initialize();
  Fimber.plantTree(DebugTree());
  runApp(App());
}
