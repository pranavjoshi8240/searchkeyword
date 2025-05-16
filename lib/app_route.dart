import 'package:get/get.dart';
import 'package:searchkeyword/View/SearchScreen/search_screen_binding.dart';
import 'package:searchkeyword/View/SearchScreen/search_screen_view.dart';



class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: SearchScreenView.routeName,
      page: () =>  const SearchScreenView(),
      bindings: SearchBinding.bindings,
    ),
  ];
}