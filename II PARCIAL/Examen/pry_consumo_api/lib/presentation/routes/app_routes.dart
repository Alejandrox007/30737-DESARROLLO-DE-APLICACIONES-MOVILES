import 'package:flutter/material.dart';
import '../views/main_navigation_page.dart';
import '../views/poliza_detail_page.dart';
import '../views/edit_poliza_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    "/": (_) => const MainNavigationPage(),
    "/detalle": (_) => const PolizaDetailPage(),
    "/editar": (_) => const EditPolizaPage(),
  };
}

