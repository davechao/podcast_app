import 'package:flutter/material.dart';
import 'package:podcastapp/model/config.dart';

class ConfigProvider extends InheritedWidget {
  final Config config;

  ConfigProvider({
    @required this.config,
    @required Widget child,
  }) : super(child: child);

  static ConfigProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ConfigProvider>();
  }

  @override
  bool updateShouldNotify(ConfigProvider oldWidget) =>
      config != oldWidget.config;
}
