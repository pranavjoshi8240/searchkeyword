import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:searchkeyword/View/SearchScreen/search_screen_controller.dart';


class SearchBinding{
  static List<Bindings> bindings =  [
    BindingsBuilder.put(() => SearchScreenController()),
  ];
}