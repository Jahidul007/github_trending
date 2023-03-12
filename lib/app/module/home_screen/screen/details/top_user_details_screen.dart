import 'package:flutter/material.dart';
import 'package:github_trending/app/module/core/screen/base_page_screen.dart';
import 'package:github_trending/app/module/core/screen/base_screen.dart';
import 'package:github_trending/app/module/home_screen/controller/top_user_details_controller.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_user/top_user_response.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_user/user_response.dart';
import 'package:github_trending/app/module/widget/custom_height_width.dart';
import 'package:github_trending/app/module/widget/full_screen_message_widget.dart';
import 'package:github_trending/app/module/widget/item_with_value.dart';
import 'package:github_trending/app/module/widget/profile_picture.dart';
import 'package:github_trending/app/utils/constants.dart';
import 'package:github_trending/app/utils/util_values.dart';

class TopUserDetailsScreen extends BasePageScreen {
  final Items items;

  const TopUserDetailsScreen({Key? key, required this.items}) : super(key: key);

  @override
  State<TopUserDetailsScreen> createState() => _TopUserDetailsScreenState();
}

class _TopUserDetailsScreenState extends BaseScreen<TopUserDetailsScreen> {
  final TopUserDetailsController topUserDetailsController =
      TopUserDetailsController();

  @override
  void initState() {
    super.initState();
    if (widget.items.login != null) {
      topUserDetailsController.getUserDetails(userName: widget.items.login!);
    }
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      title: const Text("User Details"),
      centerTitle: true,
    );
  }

  @override
  bindControllers() {
    addControllers(topUserDetailsController);
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: StreamBuilder<UserResponse?>(
        stream: topUserDetailsController.userDetailsStream,
        builder: (context, snapshot) {
          UserResponse? userResponse;
          if (snapshot.hasData) {
            userResponse = snapshot.data;
            if (userResponse == null) {
              return const FullScreenMessageWidget(
                message: "There is no user found",
              );
            }
          }
          return userResponse != null
              ? Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ProfilePicture(widget.items.avatarUrl, false),
                              customHeight(),
                              Text(
                                getDisplayText(widget.items.login),
                                style: body2regular,
                              ),
                              customHeight(),
                              Text(
                                getDisplayText(userResponse.bio),
                                style: captionRegular,
                              ),
                              customHeight()
                            ],
                          ),
                        ),
                      ),
                    ),
                    customHeight(height: 16),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ItemWithValue(
                                "Name", getDisplayText(userResponse.name)),
                            customHeight(),
                            ItemWithValue(
                                "Company", getDisplayText(userResponse.company)),
                            customHeight(),
                            ItemWithValue("Location",
                                getDisplayText(userResponse.location)),
                            customHeight(),
                            ItemWithValue(
                                "Repos",
                                getDisplayText(
                                    userResponse.publicRepos.toString())),
                            customHeight(),
                            ItemWithValue(
                                "Gist",
                                getDisplayText(
                                    userResponse.publicGists.toString())),
                            customHeight(),
                            ItemWithValue(
                                "Followers",
                                getDisplayText(
                                    userResponse.followers.toString())),
                            customHeight(),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Container();
        },
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
    return greyBgColor;
  }
}
