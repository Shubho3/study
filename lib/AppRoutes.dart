import 'package:get/get_navigation/src/routes/get_route.dart';

import 'MasterDataScreen.dart';

class Routes {
  static const masterData = '/masterData';

  static final pages = [
    GetPage(
      name: masterData,
      page: () => MasterDataScreen(),
    ),
    // Add more routes for Add, Update, Delete screens if needed
  ];
}
