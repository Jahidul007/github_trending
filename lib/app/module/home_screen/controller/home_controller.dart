import 'package:github_trending/app/module/core/controller/base_controller.dart';
import 'package:github_trending/app/module/home_screen/controller/top_repositories_controller.dart';
import 'package:github_trending/app/module/home_screen/controller/top_user_by_country_controller.dart';
import 'package:github_trending/app/module/home_screen/data/enum/menu_item_type.dart';
import 'package:rxdart/rxdart.dart';

class HomeController extends BaseController
    with TopUserController, TopRepositoriesController {
  final BehaviorSubject<MenuItemType> _menuItemController =
      BehaviorSubject<MenuItemType>.seeded(MenuItemType.topUserByCountry);

  Stream<MenuItemType> get menuItemStream => _menuItemController.stream;

  updateMenuItem(MenuItemType menuItemType){
    _menuItemController.sink.add(menuItemType);
    resetAll();
  }

  @override
  void dispose() {
    _menuItemController.close();
    super.dispose();
  }
}
