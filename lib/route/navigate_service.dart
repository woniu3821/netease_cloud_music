import 'package:flutter/material.dart';

class NavigateService {
  final GlobalKey<NavigatorState> key = GlobalKey(debugLabel: 'navigate_key');

  NavigatorState get navigator => key.currentState;

  get pushedNamed => navigator.pushNamed;
  get push => navigator.push;
  get popAndPushNamed => navigator.popAndPushNamed;
}
