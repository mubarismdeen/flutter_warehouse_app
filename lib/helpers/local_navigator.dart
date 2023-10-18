import 'package:admin/constants/controllers.dart';
import 'package:flutter/widgets.dart';

import '../globalState.dart';
import '../routes/router.dart';
import '../routes/routes.dart';

Navigator localNavigator() => Navigator(
  key: navigationController.navigationkey,
  initialRoute: DashboardRoute,
  onGenerateRoute: generateRoute,
);