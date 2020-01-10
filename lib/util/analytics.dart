//import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  Analytics._();

  static Analytics _instance;

  factory Analytics() {
    _instance ??= Analytics._();
    return _instance;
  }

//  final FirebaseAnalytics firebase = FirebaseAnalytics();
}
