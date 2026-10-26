import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';
import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Clean URLs (/orders/abc instead of /#/orders/abc) so links look real and
  // deep links work. The dev server and the hosting rewrite all paths to
  // index.html.
  usePathUrlStrategy();
  await configureDependencies();
  runApp(const RefreshiApp());
}
