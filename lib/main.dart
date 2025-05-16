import 'package:flutter/material.dart';
import 'package:searchkeyword/View/SearchScreen/search_screen_view.dart';
import 'package:searchkeyword/app_route.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      initialRoute: SearchScreenView.routeName,
    );
  }
}

