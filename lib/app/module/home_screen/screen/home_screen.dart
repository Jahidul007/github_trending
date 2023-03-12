import 'package:flutter/material.dart';
import 'package:github_trending/app/module/core/screen/base_page_screen.dart';
import 'package:github_trending/app/module/core/screen/base_screen.dart';
import 'package:github_trending/app/module/home_screen/controller/home_controller.dart';
import 'package:github_trending/app/module/home_screen/data/enum/menu_item_type.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_repository/top_repository_response.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_user/top_user_response.dart';
import 'package:github_trending/app/module/widget/button_with_icon.dart';
import 'package:github_trending/app/module/widget/custom_card.dart';
import 'package:github_trending/app/module/widget/custom_divider.dart';
import 'package:github_trending/app/module/widget/custom_height_width.dart';
import 'package:github_trending/app/module/widget/full_screen_message_widget.dart';
import 'package:github_trending/app/module/widget/title_with_background.dart';
import 'package:github_trending/app/utils/constants.dart';
import 'package:github_trending/app/utils/util_values.dart';
import 'package:github_trending/route/github_trending_app_route.dart';

import 'widget/menu_item_widget.dart';

class HomeScreen extends BasePageScreen {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen> {
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    super.initState();
    _homeController.getTopUsers();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      title: const Text('Github Trending'),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showMenuItems();
            },
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }

  showMenuItems() {
    return showMenuDialog(context, _homeController);
  }

  @override
  bindControllers() {
    addControllers(_homeController);
  }

  @override
  Widget body() {
    return StreamBuilder<MenuItemType>(
      stream: _homeController.menuItemStream,
      builder: (context, snapshot) {
        MenuItemType menuItemType = MenuItemType.topUserByCountry;
        if (snapshot.hasData) {
          menuItemType = snapshot.data!;
        }
        return menuItemType == MenuItemType.topUserByCountry
            ? getTopUsersByCountry()
            : getTopRepository();
      },
    );
  }

  getTopRepository() {
    return StreamBuilder<TopRepositoryResponse?>(
      stream: _homeController.topRepositoriesStream,
      builder: (context, snapshot) {
        TopRepositoryResponse? topRepositoryResponse;
        if (snapshot.hasData) {
          topRepositoryResponse = snapshot.data;
          if (topRepositoryResponse!.totalCount! <= 0) {
            return const FullScreenMessageWidget(message: "There is no data");
          }
        }

        return topRepositoryResponse != null
            ? Stack(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    itemCount: topRepositoryResponse.items != null
                        ? topRepositoryResponse.items!.length
                        : 0,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        title: getDisplayText(
                          topRepositoryResponse!.items![index].name,
                        ),
                        online: false,
                        imageUrl: topRepositoryResponse
                                .items![index].owner?.avatarUrl ??
                            "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
                        subRow1: Text(
                          getDisplayText(
                              topRepositoryResponse.items![index].description),
                          style: body2regular,
                        ),
                        subRow2: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: TitleWithBackground(
                                  title: getDisplayText(
                                topRepositoryResponse.items![index].language,
                              )),
                            ),
                            customWidth(),
                            ButtonWithIcon(
                                icon: "assets/images/ic_star.png",
                                title: getDisplayText(topRepositoryResponse
                                    .items![index].stargazersCount
                                    .toString()),
                                onTap: () {}),
                            customWidth(),
                            ButtonWithIcon(
                                icon: "assets/images/ic_fork.png",
                                title: getDisplayText(topRepositoryResponse
                                    .items![index].forksCount
                                    .toString()),
                                onTap: () {})
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context,
                              GithubAppRoute.topRepositoryDetailsScreen,
                              arguments: topRepositoryResponse!.items![index]);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => customDividerGrey(),
                  ),
                  _getTotal(topRepositoryResponse.items!=null?topRepositoryResponse.items!.length:0),
                ],
              )
            : Container();
      },
    );
  }

  getTopUsersByCountry() {
    return StreamBuilder<TopUserResponse?>(
      stream: _homeController.topUsersStream,
      builder: (context, snapshot) {
        TopUserResponse? topUserResponse;
        if (snapshot.hasData) {
          topUserResponse = snapshot.data;
          if (topUserResponse!.totalCount! <= 0) {
            return const FullScreenMessageWidget(message: "There is no data");
          }
        }

        return topUserResponse != null
            ? Stack(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    itemCount: topUserResponse.items != null
                        ? topUserResponse.items!.length
                        : 0,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        title: getDisplayText(
                          topUserResponse!.items![index].login,
                        ),
                        online: false,
                        imageUrl: topUserResponse.items![index].avatarUrl ??
                            "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
                        onTap: () {
                          Navigator.pushNamed(
                              context, GithubAppRoute.topUserDetailsScreen,
                              arguments: topUserResponse!.items![index]);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => customDividerGrey(),
                  ),
                  _getTotal(topUserResponse.items!=null?topUserResponse.items!.length:0)
                ],
              )
            : Container();
      },
    );
  }

 Widget _getTotal(int totalCount) {
    return Positioned.fill(
      bottom: 10,
      right: 10,
      child: Align(
        alignment: Alignment.bottomRight,
        child: FractionallySizedBox(
          widthFactor: 0.4,
          child: TitleWithBackground(
            title: getDisplayText('Total: $totalCount'),
            bgColor: primaryColorMap.entries.first.value,

          ),
        ),
      ),
    );
  }

  @override
  Widget? floatingActionButton() {
    return null;
  }

  @override
  void onClickBackButton() {}

  @override
  Color? pageBackgroundColor() {
    return null;
  }
}
